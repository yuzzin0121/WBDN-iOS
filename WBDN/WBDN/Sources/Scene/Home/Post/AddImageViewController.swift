//
//  AddImageViewController.swift
//  WBDN
//
//  Created by 박민서 on 11/26/23.
//


import UIKit
import SnapKit
import Then
//1. import PhotosUI
import PhotosUI

class AddImageViewController: UIViewController {
    
    private var imageLoadResult : [String:Any] = [:]
    
    // 이미지를 첨부해주세요 대문 라벨
    lazy var titleLabel: UILabel = UILabel().then {
        $0.textColor = .white
        $0.font = .pretendard(size: 17, weight: .semiBold)
        
        // text 색 분할 지정
        let text = "이미지를 첨부해주세요!*"
        
        let attributedText = NSMutableAttributedString(string: text)
        attributedText.addAttribute(.foregroundColor, value: UIColor.orange, range: NSRange(location: 12, length: 1))
        $0.attributedText = attributedText
    }
    
    // 이미지 불러오기 네모 칸
    lazy var addImageView:UIView = UIView().then {
        $0.backgroundColor = .customMidGray
        $0.layer.cornerRadius = 15
        $0.clipsToBounds = true
    }
    
    // 이미지 불러오기 아이콘 이미지
    lazy var addImageIcon:UIImageView = UIImageView().then{
        $0.image = UIImage(named: "addImage")
    }
    
    // 이미지 불러오기 라벨
    lazy var addImageLabel:UILabel = UILabel().then {
        $0.text = "이미지 불러오기"
        $0.textColor = .white
        $0.font = .pretendard(size: 15, weight: .medium)
    }
    
    // 다음 버튼
    lazy var nextButton: UIButton = UIButton().then {
        var titleAttr = AttributedString.init("다음")
        titleAttr.font = .pretendard(size: 17, weight: .semiBold)

        $0.configuration = .filled()
        $0.configuration?.attributedTitle = titleAttr
        $0.configuration?.baseForegroundColor = .black
        $0.configuration?.baseBackgroundColor = .customYellow
        $0.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20)
        
        $0.layer.cornerRadius = 25
        $0.clipsToBounds = true
    }
    
    // MARK: PHPicker 선언
    lazy var picker: PHPickerViewController = {
           //2. Create PHPickerConfiguration
           var configuration = PHPickerConfiguration()
           configuration.selectionLimit = 1
           configuration.filter = .any(of: [.images])
           //3. Initialize PHPicker
           let picker = PHPickerViewController(configuration: configuration)
           return picker
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .customNavy
        
        setUpView()
        setUpDelegate()
        setUpLayout()
        setUpConstraint()
        
        
    }//: viewDidLoad()
    
    // MARK: set component config
    private func setUpView() {
        
        // 탭 제스처 생성
        let addImageTapGesture = UITapGestureRecognizer(target: self, action: #selector(addImage))
                
        // addImageView에 제스처 추가
        addImageView.addGestureRecognizer(addImageTapGesture)
        
        nextButton.addTarget(self, action: #selector(tappedNext), for: .touchUpInside)
        
//        // 로그인 버튼
//        loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
//        
//        // 회원가입 버튼
//        signUpButton.addTarget(self, action: #selector(signUp), for: .touchUpInside)
    }
    
    // MARK: Delegate
    private func setUpDelegate() {
        picker.delegate = self
    }
    
    // MARK: addSubView
    private func setUpLayout() {
        
        [
            titleLabel,
            addImageView,
            nextButton
        ].forEach { self.view.addSubview($0)}
        
        // 이미지 불러오기 뷰
        [
            addImageLabel,
            addImageIcon
        ].forEach { addImageView.addSubview($0)}
    }
    
    // MARK: setConstraint
    private func setUpConstraint() {
        
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(30)
        }
        
        addImageIcon.snp.makeConstraints {
            $0.centerY.equalToSuperview().offset(-24)
            $0.centerX.equalToSuperview()
        }
        
        addImageLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview().offset(24)
            $0.centerX.equalToSuperview()
        }
        
        addImageView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(30)
            $0.left.equalToSuperview().offset(17)
            $0.right.equalToSuperview().offset(-17)
            $0.height.equalTo(400)
        }
        
        nextButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-47)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.height.equalTo(55)
        }
        
    }
    
}

//4. conform PHPickerViewControllerDelegate
extension AddImageViewController: PHPickerViewControllerDelegate {
    
    //사용자가 사진을 선택했을 때 불리는 메서드
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        

        guard !results.isEmpty else {   // 사용자가 ‘취소’ 버튼을 눌렀을 때 / 선택 안했을 때
            // dismiss
            picker.dismiss(animated: true, completion: nil)
            return
        }

        let imageResult = results[0] // 추가한 이미지 리스트 중 첫번째
            
        // UIImage 타입으로 해당 이미지 파일을 로드할 수 있는지 여부를 체크.
        guard imageResult.itemProvider.canLoadObject(ofClass: UIImage.self) else { return  }

        // hasItemConformingToTypeIdentifier - 특정 데이터 타입에 대해 가능한지 확인해주는 역할 - 파일 자체의 데이터 타입을 구분
        if imageResult.itemProvider.hasItemConformingToTypeIdentifier(UTType.image.identifier) {
            // 파일의 데이터 타입에 맞춰 data return
            imageResult.itemProvider.loadDataRepresentation(forTypeIdentifier: UTType.image.identifier) { data, error in
                guard let data = data,
                        // CGImageSourceCreateWithData로 CGImage로 변환
                        let cgImageSource = CGImageSourceCreateWithData(data as CFData, nil),
                        // CGImageSourceCopyPropertiesAtIndex로 cgImageSource딕셔너리에서 정보를 가져온다
                        let properties = CGImageSourceCopyPropertiesAtIndex(cgImageSource, 0, nil) as? Dictionary<String, Any>,
                          // 이때 CGImageSourceCopyPropertiesAtIndex는 CFDictionary로 반환하는데, { "{Exif}": {width: 480, ... }, "{TIFF}": {pixel: 480, ...} } 와 같은 JSON 떡칠이라 딕셔너리로 타입캐스팅
                        let exif = properties["{Exif}"], // Exif 값을 끌고 오는데, Any 타입으로 갖고와진다.
                        let dictionary = exif as? Dictionary<String, Any> // 딕셔너리로 타입 캐스팅
                else {
                    return
                }
                imageResult.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] (selectedImage: NSItemProviderReading?, error: Error?) in
                    // 선택한 Image를 Load해 수행할 명령
                    self?.imageLoadResult = dictionary
                    DispatchQueue.main.async {
                        print(self?.imageLoadResult)
                        picker.dismiss(animated: true)
                    }
                    return
                }
            }
        }
    }
    
    
    @objc func addImage() {
        present(picker, animated: true, completion: nil)
    }
    
    @objc func tappedNext() {
        print("go to next")
        let nextVC = PhotoInfoViewController()
        nextVC.metaDataDictionary = imageLoadResult
        self.navigationController?.pushViewController(nextVC, animated: true)
        // 여기에서 imageLoadResult 넘겨주면 됩니다.
        // 대충 로그인 API 호출
    }
}

// Preview Code
//@available(iOS 17.0, *)
//#Preview("AddImageViewController") {
//    AddImageViewController()
//}






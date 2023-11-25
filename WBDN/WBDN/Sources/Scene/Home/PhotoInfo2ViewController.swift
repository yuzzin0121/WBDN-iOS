//
//  PhotoInfo2ViewController.swift
//  WBDN
//
//  Created by 박민서 on 11/26/23.
//

import UIKit
import SnapKit
import Then
import MapKit

class PhotoInfo2ViewController: UIViewController {
    
    private var location = CLLocationCoordinate2D()
    private var date = Date()
    
    // "추가 정보를 입력해주세요!" 라벨
    lazy var titleLabel: UILabel = UILabel().then {
        $0.text = "추가 정보를 입력해주세요! (선택)"
        $0.textColor = UIColor.white // 색 수정 필요
        $0.font = .pretendard(size: 17, weight: .semiBold)
    }
    
    // "후보정 방법" 라벨
    lazy var editMethodLabel: UILabel = UILabel().then {
        $0.text = "후보정 방법"
        $0.textColor = UIColor.white // 색 수정 필요
        $0.font = .pretendard(size: 15, weight: .semiBold)
    }
    
    // 후보정 방법 텍스트뷰
    lazy var editMethodTextView: UITextView = UITextView().then {
        $0.layer.cornerRadius = 15
        $0.font = .pretendard(size: 11, weight: .medium)
        $0.textAlignment = .left
        $0.textColor = .customLightGray
        $0.backgroundColor = .customMidGray
        $0.contentInset = UIEdgeInsets(top: 15, left: 20, bottom: 15, right: 20)
        $0.text = "나만의 보정 방법을 자유롭게 작성해주세요!"
    }
    
    // "추가 코멘트" 라벨
    lazy var commentLabel: UILabel = UILabel().then {
        $0.text = "추가 코멘트"
        $0.textColor = UIColor.white // 색 수정 필요
        $0.font = .pretendard(size: 15, weight: .semiBold)
    }
    
    // 추가 코멘트 텍스트뷰
    lazy var commentTextView: UITextView = UITextView().then {
        $0.layer.cornerRadius = 15
        $0.font = .pretendard(size: 11, weight: .medium)
        $0.textAlignment = .left
        $0.textColor = .customLightGray
        $0.backgroundColor = .customMidGray
        $0.contentInset = UIEdgeInsets(top: 15, left: 20, bottom: 15, right: 20)
        $0.text = "우밤이들에게 공유하고 싶은 나만의 촬영 꿀팁이 있나요?"
    }
    
    // 위치 아이콘
    lazy var locationImage: UIImageView = UIImageView().then {
        $0.image = UIImage(resource: .yelloStar)
    }
    
    // 위치 라벨
    lazy var locationLabel: UILabel = UILabel().then {
        $0.text = "위치"
        $0.textColor = UIColor.white
        $0.font = .pretendard(size: 15, weight: .semiBold)
    }
    
    // "위치 정보 추가하기" 버튼
    lazy var addLocationButton: UIButton = UIButton().then {
        $0.layer.cornerRadius = 15
        var titleAttr = AttributedString.init("위치 정보 추가하기")
        titleAttr.font = .pretendard(size: 11, weight: .semiBold)

        $0.configuration = .filled()
        $0.configuration?.attributedTitle = titleAttr
        $0.configuration?.baseForegroundColor = .white
        $0.configuration?.baseBackgroundColor = .customMidGray
        $0.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 6, leading: 10, bottom: 6, trailing: 10)
        $0.configuration?.cornerStyle = .capsule
    }
    
    // 날짜 아이콘
    lazy var dateImage: UIImageView = UIImageView().then {
        $0.image = UIImage(resource: .yelloStar)
    }
    
    // 날짜 라벨
    lazy var dateLabel: UILabel = UILabel().then {
        $0.text = "찍은 날짜"
        $0.textColor = UIColor.white
        $0.font = .pretendard(size: 15, weight: .semiBold)
    }
    
    // "날짜 정보 추가하기" 버튼
    lazy var addDateButton: UIButton = UIButton().then {
        var titleAttr = AttributedString.init("날짜 정보 추가하기")
        titleAttr.font = .pretendard(size: 11, weight: .semiBold)

        $0.configuration = .filled()
        $0.configuration?.attributedTitle = titleAttr
        $0.configuration?.baseForegroundColor = .white
        $0.configuration?.baseBackgroundColor = .customMidGray
        $0.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 6, leading: 10, bottom: 6, trailing: 10)
        $0.configuration?.cornerStyle = .capsule
    }
 

    // 등록하기 버튼
    lazy var postButton: UIButton = UIButton().then {
        
        var titleAttr = AttributedString.init("등록하기")
        titleAttr.font = .pretendard(size: 17, weight: .semiBold)

        $0.configuration = .filled()
        $0.configuration?.attributedTitle = titleAttr
        $0.configuration?.baseForegroundColor = .black
        $0.configuration?.baseBackgroundColor = .customYellow
        $0.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20)
        
        $0.layer.cornerRadius = 25
        $0.clipsToBounds = true
    }
    
    // 달력 피커
    lazy var datePicker: UIDatePicker = UIDatePicker().then {
        $0.preferredDatePickerStyle = .inline // 캘린더 타입
        $0.datePickerMode = .date // 날짜로 설정
        $0.locale = Locale(identifier: "ko-KR") // 기본 위치
        $0.timeZone = .autoupdatingCurrent // 시간대 반영
        $0.tintColor = .customYellow
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 15
        $0.clipsToBounds = true
        $0.isHidden = true
    }
    
    // 달력 피커 배경
    lazy var datePickerBackGround: UIView = UIView().then{
        $0.backgroundColor = .white.withAlphaComponent(0.5)
        $0.isHidden = true
    }
    
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
        
        addLocationButton.addTarget(self, action: #selector(presentLocationPopUp), for: .touchUpInside)
        
        addDateButton.addTarget(self, action: #selector(presentDatePickerPopUp), for: .touchUpInside)
        
        datePicker.addTarget(self, action: #selector(setDate), for: .valueChanged)
        
        // 탭 제스처 생성
        let dismissTapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissDatePicker))
                
        // addImageView에 제스처 추가
        datePickerBackGround.addGestureRecognizer(dismissTapGesture)
        
        postButton.addTarget(self, action: #selector(postData), for: .touchUpInside)
    }
    
    // MARK: Delegate
    private func setUpDelegate() {
        editMethodTextView.delegate = self
        commentTextView.delegate = self
    }
    
    // MARK: addSubView
    private func setUpLayout() {
        [
            titleLabel,
            editMethodLabel,
            editMethodTextView,
            commentLabel,
            commentTextView,
            locationImage,
            locationLabel,
            addLocationButton,
            dateImage,
            dateLabel,
            addDateButton,
            postButton,
            datePickerBackGround,
            datePicker
        ].forEach { self.view.addSubview($0)}
    }
    
    // MARK: setConstraint
    private func setUpConstraint() {
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(15)
            $0.left.equalToSuperview().offset(16)
        }
        
        editMethodLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.left.equalTo(titleLabel)
        }
        
        editMethodTextView.snp.makeConstraints {
            $0.top.equalTo(editMethodLabel.snp.bottom).offset(5)
            $0.left.equalTo(editMethodLabel)
            $0.right.equalToSuperview().offset(-16)
            $0.height.equalTo(95)
        }
        
        commentLabel.snp.makeConstraints {
            $0.top.equalTo(editMethodTextView.snp.bottom).offset(10)
            $0.left.equalTo(editMethodTextView)
        }
        
        commentTextView.snp.makeConstraints {
            $0.top.equalTo(commentLabel.snp.bottom).offset(5)
            $0.left.equalTo(commentLabel)
            $0.right.equalToSuperview().offset(-16)
            $0.height.equalTo(95)
        }
        
        locationImage.snp.makeConstraints {
            $0.top.equalTo(commentTextView.snp.bottom).offset(15)
            $0.left.equalTo(commentTextView)
            $0.size.equalTo(20)
        }
        
        locationLabel.snp.makeConstraints {
            $0.centerY.equalTo(locationImage)
            $0.left.equalTo(locationImage.snp.right).offset(7)
        }
        
        addLocationButton.snp.makeConstraints {
            $0.top.equalTo(locationImage.snp.bottom)
            .offset(6)
            $0.left.equalTo(locationImage)
            $0.height.equalTo(30)
            $0.width.equalTo(190)
        }
        
        dateImage.snp.makeConstraints {
            $0.top.equalTo(addLocationButton.snp.bottom).offset(15)
            $0.left.equalTo(addLocationButton)
            $0.size.equalTo(20)
        }
        
        dateLabel.snp.makeConstraints {
            $0.centerY.equalTo(dateImage)
            $0.left.equalTo(dateImage.snp.right).offset(7)
        }
        
        addDateButton.snp.makeConstraints {
            $0.top.equalTo(dateImage.snp.bottom)
            .offset(6)
            $0.left.equalTo(dateImage)
            $0.height.equalTo(30)
            $0.width.equalTo(190)
        }
        
        datePicker.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        datePickerBackGround.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        //------등록하기 버튼
        
        postButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-47)
            $0.height.equalTo(55)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
        }
    }
    
}

extension PhotoInfo2ViewController: UITextViewDelegate {
    
    // placholder 처리
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if textView == editMethodTextView {
            textView.text = nil
        }
        
        if textView == commentTextView {
            textView.text = nil
        }
        
    }
    
    //placeholder 처리
    func textViewDidEndEditing(_ textView: UITextView) {

        if textView == editMethodTextView && textView.text.isEmpty {
            textView.text = "나만의 보정 방법을 자유롭게 작성해주세요!"
        }
        
        if textView == commentTextView && textView.text.isEmpty {
            textView.text = "우밤이들에게 공유하고 싶은 나만의 촬영 꿀팁이 있나요?"
        }
    }
    
    // 키보드 내리기
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        textView.resignFirstResponder()
        return true
    }
    
    // 위치 검색 VC 팝업
    @objc func presentLocationPopUp() {
        print("Set Location")
        let searchLocationVC = SearchLocationViewController()
        
        searchLocationVC.completionHandler = {
            [weak self] coordinate in
                
            print(coordinate)
        }
       
        self.present(searchLocationVC, animated: true, completion: nil)
    }
    
    @objc func presentDatePickerPopUp() {
        print("Pick Date")
        datePicker.isHidden = false
        datePickerBackGround.isHidden = false
        
    }
    
    /// 피커의 결과값 반환
    @objc func setDate(_ sender: UIDatePicker) {
        //라벨의 text 설정
        self.date = sender.date
    }
    
    @objc func dismissDatePicker() {
        datePicker.isHidden = true
        datePickerBackGround.isHidden = true
    }
    
    @objc func postData() {
        print("post data")
        // 대충 data post API 호출
    }
}

// Preview Code
@available(iOS 17.0, *)
#Preview("PhotoInfo2ViewController") {
    PhotoInfo2ViewController()
}





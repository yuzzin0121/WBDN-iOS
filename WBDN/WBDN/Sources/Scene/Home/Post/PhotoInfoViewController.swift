//
//  PhotoInfoViewController.swift
//  WBDN
//
//  Created by 조유진 on 2023/11/25.
//

import UIKit
import Then
import SnapKit

class PhotoInfoViewController: UIViewController {
    
    
    var metaDataDictionary: [String:Any] = [:]
    
    struct Constants {
        static let cornerRadius: CGFloat = 16.0
    }
    
    // MARK: - Properties
    lazy var photoDeviceLabel = UILabel().then {
        $0.font = .pretendard(size: 22, weight: .semiBold)
        $0.text = "촬영 기기를 선택해주세요! *"
        $0.textColor = .white
        
        let attributedString = NSMutableAttributedString(string: $0.text!)
        attributedString.addAttribute(.foregroundColor, value: UIColor.customRed, range: ($0.text! as NSString).range(of: "*"))
        
        $0.attributedText = attributedString
        $0.sizeToFit()
    }
    
    lazy var selectBtn: UIButton = {
        var configuration = UIButton.Configuration.filled()
        
        var container = AttributeContainer()
        container.font = .pretendard(size: 12, weight: .semiBold)
        configuration.attributedTitle = AttributedString(devices[0], attributes: container)
        configuration.background.cornerRadius = 16
        configuration.baseBackgroundColor = .customLightNavy
        let button = UIButton(configuration: configuration, primaryAction: nil)
        button.setTitleColor(.white, for: .normal)
        button.contentHorizontalAlignment = .leading
        button.tintColor = .white
        return button
    }()
    
    lazy var addPhotoInfoLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        $0.text = "추가 촬영정보가 있다면 입력해주세요! (선택)"
        $0.textColor = .white
    }
    
    lazy var isoLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        $0.text = "ISO"
        $0.textColor = .customLightGray2
    }
    
    lazy var speedLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        $0.text = "셔터 스피드"
        $0.textColor = .customLightGray2
    }
    
    lazy var apertureLabel = UILabel().then {
        $0.font = .pretendard(size: 20, weight: .semiBold)
        $0.text = "조리개 값"
        $0.textColor = .customLightGray2
    }
    
    lazy var isoTextField = UITextField().then {
        $0.textColor = .customLightGray3
        $0.font = .pretendard(size: 14, weight: .medium)
        // Placeholder 텍스트 속성 설정
        let placeholderText = "ex) 640"
        let attributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.foregroundColor: UIColor.customLightGray3,
        ]

        let attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: attributes)
        $0.autocorrectionType = .no
        $0.attributedPlaceholder = attributedPlaceholder
        $0.backgroundColor = .customLightNavy
        $0.leftViewMode = .always
        $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = Constants.cornerRadius
    }
    
    lazy var speedTextField = UITextField().then {
        $0.textColor = .customLightGray3
        $0.font = .pretendard(size: 14, weight: .medium)
        // Placeholder 텍스트 속성 설정
        let placeholderText = "ex) 1/8 s"
        let attributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.foregroundColor: UIColor.customLightGray3,
        ]

        let attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: attributes)
        $0.autocorrectionType = .no
        $0.attributedPlaceholder = attributedPlaceholder
        $0.backgroundColor = .customLightNavy
        $0.leftViewMode = .always
        $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = Constants.cornerRadius
    }
    
    lazy var apertureTextField = UITextField().then {
        $0.textColor = .customLightGray3
        $0.font = .pretendard(size: 14, weight: .medium)
        // Placeholder 텍스트 속성 설정
        let placeholderText = "ex) f 1.8"
        let attributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.foregroundColor: UIColor.customLightGray3,
        ]

        let attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: attributes)
        $0.autocorrectionType = .no
        $0.attributedPlaceholder = attributedPlaceholder
        $0.backgroundColor = .customLightNavy
        $0.leftViewMode = .always
        $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = Constants.cornerRadius
    }
    
    lazy var nextButton = UIButton().then {
        $0.backgroundColor = .customYellow
        $0.titleLabel?.font = .pretendard(size: 17, weight: .semiBold)
        $0.setTitle("다음", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        
        $0.layer.cornerRadius = 16
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner]
    }
    
    var menuChildren: [UIMenuElement] = []
    
    let devices = ["DSLR / 미러리스", "Android 기기", "기타 기기", "iPhone 15 Pro", "iPhone 15", "iPhone 15 Plus", "iPhone 14 Pro Max"]

    // MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setUpLayout()
        setUpConstraint()
        setDeviceData()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let isoValue = metaDataDictionary["ISOSpeedRatings"] as? Float else {
            print("없음   ")
            return
        }
        print(String(format: "%.2f", isoValue))
        isoTextField.text = String(format: "%.2f", isoValue)
        
        guard let speedValue = metaDataDictionary["ShutterSpeedValue"] as? Float else {
            return
        }
        speedTextField.text = String(format: "%.2f", speedValue)
        
        guard let apertureValue = metaDataDictionary["ApertureValue"] as? Float else {
            return
        }
        apertureTextField.text = String(format: "%.2f", apertureValue)
    }
    
    // MARK: - View
    func setUpView() {
        self.view.backgroundColor = .customNavy
        nextButton.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
    }
    
    // MARK: - Layout
    func setUpLayout() {
        [photoDeviceLabel, selectBtn, addPhotoInfoLabel, isoLabel, speedLabel, apertureLabel, isoTextField, speedTextField, apertureLabel, apertureTextField, nextButton].forEach {
            self.view.addSubview($0)
        }
    }
    
    // MARK: - Constraint
    func setUpConstraint() {
        // 촬영 기기를 선택해주세요!*
        photoDeviceLabel.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(10)
            $0.leading.equalToSuperview().offset(16)
        }
        
        selectBtn.snp.makeConstraints {
            $0.top.equalTo(photoDeviceLabel.snp.bottom).offset(20)
            $0.leading.equalTo(16)
            $0.width.equalTo(200)
            $0.height.equalTo(38)
        }
        
        addPhotoInfoLabel.snp.makeConstraints {
            $0.top.equalTo(selectBtn.snp.bottom).offset(28)
            $0.leading.equalToSuperview().offset(16)
        }
        
        isoLabel.snp.makeConstraints {
            $0.top.equalTo(addPhotoInfoLabel.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(16)
        }
        
        isoTextField.snp.makeConstraints {
            $0.top.equalTo(isoLabel.snp.bottom).offset(4)
            $0.leading.equalToSuperview().offset(16)
            $0.width.equalTo(self.view.bounds.width * 0.4)
            $0.height.equalTo(42)
        }
        
        speedLabel.snp.makeConstraints {
            $0.top.equalTo(isoTextField.snp.bottom).offset(15)
            $0.leading.equalToSuperview().offset(16)
        }
        
        speedTextField.snp.makeConstraints {
            $0.top.equalTo(speedLabel.snp.bottom).offset(4)
            $0.leading.equalToSuperview().offset(16)
            $0.width.equalTo(self.view.bounds.width * 0.4)
            $0.height.equalTo(42)
        }
        
        apertureLabel.snp.makeConstraints {
            $0.top.equalTo(speedTextField.snp.bottom).offset(15)
            $0.leading.equalToSuperview().offset(16)
        }
        apertureTextField.snp.makeConstraints {
            $0.top.equalTo(apertureLabel.snp.bottom).offset(4)
            $0.leading.equalToSuperview().offset(16)
            $0.width.equalTo(self.view.bounds.width * 0.4)
            $0.height.equalTo(42)
        }
        
        nextButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-47)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.height.equalTo(55)
        }
    }
    
    // MARK: - Delegate
    func setUpDelegate() {
        isoTextField.delegate = self
        speedTextField.delegate = self
        apertureTextField.delegate = self
    }
    
    // MARK: - Set Data
    func setDeviceData() {
        for device in devices {
            menuChildren.append(UIAction(title: device, handler: {  (action: UIAction) in
                self.changeDeviceTitle(action.title)
            }))
        }
        selectBtn.menu = UIMenu(options: .displayInline, children: menuChildren)
        
        selectBtn.showsMenuAsPrimaryAction = true
        selectBtn.changesSelectionAsPrimaryAction = true
        
    }
    
    func changeDeviceTitle(_ title: String) {
        selectBtn.setTitle(title, for: .normal)
    }
    

    // MARK: - Button Tap
    @objc func didTapNextButton() {
        isoTextField.resignFirstResponder()
        speedTextField.resignFirstResponder()
        apertureTextField.resignFirstResponder()
        
        let nextVC = PhotoInfo2ViewController()
        nextVC.metaDataDictionary = self.metaDataDictionary
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}

extension PhotoInfoViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == isoTextField {
            textField.resignFirstResponder()
            speedTextField.becomeFirstResponder()
        }
        else if textField == speedTextField {
            textField.resignFirstResponder()
            apertureTextField.becomeFirstResponder()
        }
        else if textField == apertureTextField {
            textField.resignFirstResponder()
            didTapNextButton()
        }
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(true)
        }
    
   
}

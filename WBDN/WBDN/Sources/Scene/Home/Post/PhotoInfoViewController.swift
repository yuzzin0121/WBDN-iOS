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
    struct Constants {
        static let cornerRadius: CGFloat = 16.0
    }
    
    // MARK: - Properties
    lazy var photoDeviceLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        $0.text = "촬영 기기를 선택해주세요! *"
        $0.textColor = .white
        
        let attributedString = NSMutableAttributedString(string: $0.text!)
        attributedString.addAttribute(.foregroundColor, value: UIColor.customRed, range: ($0.text! as NSString).range(of: "*"))
        
        $0.attributedText = attributedString
        $0.sizeToFit()
    }
    
    lazy var selectBtn = UIButton(primaryAction: nil).then {
        $0.backgroundColor = .customLightNavy
        $0.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
        $0.contentHorizontalAlignment = .trailing
        $0.setTitle(devices[0], for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.setImage(UIImage(named: "down_arrow"), for: .normal)
        $0.tintColor = .white
        $0.semanticContentAttribute = .forceRightToLeft
        $0.titleEdgeInsets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 10)
        $0.imageEdgeInsets = UIEdgeInsets(top: 0, left: 82, bottom: 0, right: 0)
        $0.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right:0)
        $0.layer.cornerRadius = 16
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner]
    }
    
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
        $0.returnKeyType = .next
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
        $0.returnKeyType = .next
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
        $0.returnKeyType = .next
        $0.leftViewMode = .always
        $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = Constants.cornerRadius
    }
    
    lazy var nextButton = UIButton().then {
        $0.backgroundColor = .customYellow
        $0.titleLabel?.font = .pretendard(size: 17, weight: .semiBold)
        $0.setTitle("다음", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        
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
    
    // MARK: - View
    func setUpView() {
        self.view.backgroundColor = .customNavy
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
            $0.bottom.equalToSuperview().offset(47)
            $0.leading.trailing.equalToSuperview().offset(16)
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
    }
}

extension PhotoInfoViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == isoTextField {
            speedTextField.becomeFirstResponder()
        }
        else if textField == speedTextField {
            apertureTextField.becomeFirstResponder()
        }
        else if textField == apertureTextField {
            didTapNextButton()
        }
        return true
    }
   
}

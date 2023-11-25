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
        $0.titleLabel?.font = .systemFont(ofSize: 14)
        $0.contentHorizontalAlignment = .trailing
        $0.setTitle(devices[0], for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.setImage(UIImage(named: "down_arrow"), for: .normal)
        $0.tintColor = .white
        $0.semanticContentAttribute = .forceRightToLeft
        $0.titleEdgeInsets = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 100)
        $0.imageEdgeInsets = UIEdgeInsets(top: 0, left: 130, bottom: 0, right: 0)
        $0.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right:0)
        $0.layer.cornerRadius = 16
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner]
    }
    
    lazy var addPhotoInfoLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        $0.text = "촬영 기기를 선택해주세요! *"
        $0.textColor = .white
        
        let attributedString = NSMutableAttributedString(string: $0.text!)
        attributedString.addAttribute(.foregroundColor, value: UIColor.customRed, range: ($0.text! as NSString).range(of: "*"))
        
        $0.attributedText = attributedString
        $0.sizeToFit()
    }
    
    var menuChildren: [UIMenuElement] = []
    
    let devices = ["DSLR / 미러리스", "Android 기기", "기타 기기", "iPhone 15 Pro", "iPhone 15", "iPhone 15 Plus", "iPhone 14 Pro Max"]
    
//    lazy var actionClosure = { (action: UIAction) in
//        print(action.title)
//        self.selectBtn.setTitle(action.title, for: .normal)
//    }

    // MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setUpLayout()
        setUpConstraint()
        setDeviceData()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(selectBtnDidTap(_:)))
        selectBtn.addGestureRecognizer(tapGesture)
    }
    
    // MARK: - View
    func setUpView() {
        self.view.backgroundColor = .customNavy
    }
    
    // MARK: - Layout
    func setUpLayout() {
        [photoDeviceLabel, selectBtn].forEach {
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
            $0.width.equalTo(250)
            $0.height.equalTo(38)
        }
        
        
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
    @objc func selectBtnDidTap(_ gesture: UITapGestureRecognizer) {
        
    }
}

@available(iOS 17, *)
#Preview(traits: .defaultLayout, body: {
    PhotoInfoViewController()
})

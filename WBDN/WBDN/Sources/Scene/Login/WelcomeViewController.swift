//
//  WelcomeViewController.swift
//  WBDN
//
//  Created by 박민서 on 11/25/23.
//

import UIKit
import SnapKit
import Then

class WelcomeViewController: UIViewController {
    
    // "환영합니다" 제목 라벨
    lazy var titleLabel: UILabel = UILabel().then {
        $0.text = "환영합니다!"
        $0.textColor = UIColor.white // 색 수정 필요
        $0.font = .pretendard(size: 25, weight: .semiBold)
    }
    
    // "이제 다양한 밤하늘을 즐겨보세요" 라벨
    lazy var subTitleLabel: UILabel = UILabel().then {
        $0.text = "이제 다양한 밤하늘을 즐겨보세요"
        $0.textColor = .customYellow // 색 수정 필요
        $0.font = .pretendard(size: 17, weight: .medium)
    }
    
    // 팡파레 이미지
    lazy var welcomeImage: UIImageView = UIImageView().then {
        $0.image = .congrat
    }
    
    // 로그인하러가기 버튼
    lazy var goLoginButton: UIButton = UIButton().then {
        
        var titleAttr = AttributedString.init("로그인하러 가기")
        titleAttr.font = .pretendard(size: 17, weight: .semiBold)

        $0.configuration = .filled()
        $0.configuration?.attributedTitle = titleAttr
        $0.configuration?.baseForegroundColor = .black
        $0.configuration?.baseBackgroundColor = .customYellow
        $0.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20)
        
        $0.layer.cornerRadius = 25
        $0.clipsToBounds = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .customNavy // 내가 추가한 부분
        
        setUpView()
        setUpDelegate()
        setUpLayout()
        setUpConstraint()
        
        
    }//: viewDidLoad()
    
    // MARK: set component config
    private func setUpView() {
        
        goLoginButton.addTarget(self, action: #selector(goLogin), for: .touchUpInside)
    }
    
    // MARK: Delegate
    private func setUpDelegate() {
    }
    
    // MARK: addSubView
    private func setUpLayout() {
        [
            titleLabel,
            subTitleLabel,
            welcomeImage,
            goLoginButton
        ].forEach { self.view.addSubview($0)}
    }
    
    // MARK: setConstraint
    private func setUpConstraint() {
        
        welcomeImage.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-50)
            $0.size.equalTo(150)
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(welcomeImage.snp.top).offset(-40)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(subTitleLabel.snp.top).offset(-6)
        }
        
        goLoginButton.snp.makeConstraints {
            $0.left.equalToSuperview().offset(15)
            $0.right.equalToSuperview().offset(-15)
            $0.top.equalTo(welcomeImage.snp.bottom).offset(60)
            $0.height.equalTo(55)
        }
        
    }
    
}

extension WelcomeViewController {
    
    @objc func goLogin() {
        print("go to Login")
        let viewController = LoginViewController()
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: true, completion: nil)
    }

}

// Preview Code
//@available(iOS 17.0, *)
//#Preview("WelcomeViewController") {
//    WelcomeViewController()
//}





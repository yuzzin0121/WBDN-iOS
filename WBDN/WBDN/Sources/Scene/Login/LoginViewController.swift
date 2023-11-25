//
//  LoginViewController.swift
//  WBDN
//
//  Created by 박민서 on 11/25/23.
//


import UIKit
import SnapKit
import Then

class LoginViewController: UIViewController {
    
    // "우리의 밤은 당신의 낮보다 아름답다" 라벨
    lazy var titleLabel: UILabel = UILabel().then {
        $0.text = "우리의 밤은 당신의 낮보다 아름답다"
        $0.textColor = UIColor.white // 색 수정 필요
        $0.numberOfLines = 3
//        secondLabel.font = UIFont.systemFont(ofSize: 21, weight: .semibold)
    }
    
    // ID 텍스트필드
    lazy var idTextField: UITextField = UITextField().then {
        $0.placeholder = "아이디"
        $0.layer.cornerRadius = 30
        $0.clipsToBounds = true
        $0.backgroundColor = UIColor.white // 색 수정 필요
        $0.font = UIFont.systemFont(ofSize: 15)
        
        // 좌우 여백 설정
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 10))
        
        $0.leftView = paddingView
        $0.leftViewMode = .always

        $0.rightView = paddingView
        $0.rightViewMode = .always
    }
    
    // PW 텍스트필드
    lazy var pwTextField: UITextField = UITextField().then {
        $0.placeholder = "비밀번호"
        $0.layer.cornerRadius = 30
        $0.clipsToBounds = true
        $0.backgroundColor = UIColor.white // 색 수정 필요
        $0.isSecureTextEntry = true // 비밀번호 **** 표시
        $0.font = UIFont.systemFont(ofSize: 15)
        
        // 좌우 여백 설정
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 10))
        
        $0.leftView = paddingView
        $0.leftViewMode = .always

        $0.rightView = paddingView
        $0.rightViewMode = .always
    }
    
    // 로그인 버튼
    lazy var loginButton: UIButton = UIButton().then {
        
        var titleAttr = AttributedString.init("로그인")
        titleAttr.font = UIFont.systemFont(ofSize: 17)

        $0.configuration = .filled()
        $0.configuration?.attributedTitle = titleAttr
        $0.configuration?.baseForegroundColor = .black
        $0.configuration?.baseBackgroundColor = .yellow
        $0.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20)
        
        $0.layer.cornerRadius = 30
        $0.clipsToBounds = true
    }
    
    // "아직 회원이 아니신가요" 라벨
    lazy var notMemberYetLabel: UILabel = UILabel().then {
        $0.text = "아직 회원이 아니신가요?"
        $0.textColor = UIColor.white // 색 수정 필요
        $0.font = UIFont.systemFont(ofSize: 13)
    }
    
    // 회원가입 버튼
    lazy var signUpButton: UIButton = UIButton().then {
        var titleAttr = AttributedString.init("회원가입")
        titleAttr.font = UIFont.systemFont(ofSize: 13, weight: .heavy)

        $0.configuration = .filled()
        $0.configuration?.attributedTitle = titleAttr
        $0.configuration?.baseForegroundColor = .white
        $0.configuration?.baseBackgroundColor = .clear
        $0.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 7, leading: 10, bottom: 7, trailing: 10)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black // 내가 추가한 부분
        
        setUpView()
        setUpDelegate()
        setUpLayout()
        setUpConstraint()
        
        
    }//: viewDidLoad()
    
    // MARK: set component config
    private func setUpView() {
        
        // 로그인 버튼
        loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
        
        // 회원가입 버튼
        signUpButton.addTarget(self, action: #selector(signUp), for: .touchUpInside)
    }
    
    // MARK: Delegate
    private func setUpDelegate() {
    }
    
    // MARK: addSubView
    private func setUpLayout() {
        [
            titleLabel,
            idTextField,
            pwTextField,
            loginButton,
            notMemberYetLabel,
            signUpButton
        ].forEach { self.view.addSubview($0)}
    }
    
    // MARK: setConstraint
    private func setUpConstraint() {
        
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-100)
        }
        
        idTextField.snp.makeConstraints {
            $0.height.equalTo(60)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
            $0.centerY.equalToSuperview().offset(100)
        }
        
        pwTextField.snp.makeConstraints {
            $0.height.equalTo(60)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
            $0.top.equalTo(idTextField.snp.bottom).offset(20)
        }
        
        loginButton.snp.makeConstraints {
            $0.height.equalTo(60)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
            $0.top.equalTo(pwTextField.snp.bottom).offset(20)
        }
        
        notMemberYetLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview().offset(-40)
            $0.top.equalTo(loginButton.snp.bottom).offset(10)
        }
        
        signUpButton.snp.makeConstraints {
            $0.height.equalTo(notMemberYetLabel)
            $0.centerX.equalToSuperview().offset(60)
            $0.top.equalTo(notMemberYetLabel)
        }
    }
    
}

extension LoginViewController: UITextFieldDelegate {
    @objc func login() {
        let ID = self.idTextField.text
        let PW = self.pwTextField.text
        print(ID,PW)
        
        // 대충 로그인 API 호출
//        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    @objc func signUp() {
        print("go to signUp")
        // 대충 로그인 API 호출
//        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

// Preview Code
@available(iOS 17.0, *)
#Preview("LoginViewController") {
    LoginViewController()
}





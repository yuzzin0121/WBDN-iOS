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
    
    // "우리의 밤은 당신의 낮보다 아름답다" 이미지
    lazy var loginImage: UIImageView = UIImageView().then {
        $0.image = UIImage(named: "login_image")
    }
    
    // ID 텍스트필드
    lazy var idTextField: UITextField = UITextField().then {
        $0.placeholder = "아이디"
        $0.layer.cornerRadius = 30
        $0.clipsToBounds = true
        $0.backgroundColor = UIColor.white 
        $0.textColor = UIColor.customGray
        $0.font = UIFont.pretendard(size: 15, weight: .medium)
        
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
        $0.textColor = UIColor.customGray
        $0.font = UIFont.pretendard(size: 15, weight: .medium)
        
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
        titleAttr.font = UIFont.pretendard(size: 17, weight: .semiBold)

        $0.configuration = .filled()
        $0.configuration?.attributedTitle = titleAttr
        $0.configuration?.baseForegroundColor = .black
        $0.configuration?.baseBackgroundColor = .customYellow
        $0.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20)
        
        $0.layer.cornerRadius = 30
        $0.clipsToBounds = true
    }
    
    // "아직 회원이 아니신가요" 라벨
    lazy var notMemberYetLabel: UILabel = UILabel().then {
        $0.text = "아직 회원이 아니신가요?"
        $0.textColor = UIColor.white // 색 수정 필요
        $0.font = UIFont.pretendard(size: 13, weight: .medium)
    }
    
    // 회원가입 버튼
    lazy var signUpButton: UIButton = UIButton().then {
        var titleAttr = AttributedString.init("회원가입")
        titleAttr.font = UIFont.pretendard(size: 13, weight: .bold)

        $0.configuration = .filled()
        $0.configuration?.attributedTitle = titleAttr
        $0.configuration?.baseForegroundColor = .white
        $0.configuration?.baseBackgroundColor = .clear
        $0.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 7, leading: 10, bottom: 7, trailing: 10)
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
            loginImage,
            idTextField,
            pwTextField,
            loginButton,
            notMemberYetLabel,
            signUpButton
        ].forEach { self.view.addSubview($0)}
    }
    
    // MARK: setConstraint
    private func setUpConstraint() {
        
        loginImage.snp.makeConstraints {
            $0.centerX.equalToSuperview().offset(-33)
            $0.centerY.equalToSuperview().offset(-180)
        }
        
        idTextField.snp.makeConstraints {
            $0.height.equalTo(60)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
            $0.centerY.equalToSuperview().offset(80)
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
        
        guard let id = ID else { return }
        guard let pw = PW else { return }
        
        // 대충 로그인 API 호출
        
        Task {
            let response = try await NetworkService.shared.request(.signIn(dto: .init(loginId: id, password: pw)), type: BaseResponse<SignInResponse>.self)
            
            guard let accessKey = response.result?.accessKey else {
                return
            }
            
            UserDefaults.standard.set(accessKey, forKey: "accessKey")
            
            await MainActor.run(body: {
                self.dismiss(animated: true)
            })
        }
        
        
//        self.navigationController?.pushViewController(viewController, animated: true)
        
//        let viewController = MainTabController()
//        viewController.modalPresentationStyle = .fullScreen
//        present(viewController, animated: true, completion: nil)
        
    }
    
    @objc func signUp() {
        let signUpViewController = SignUpViewController()
        present(signUpViewController, animated: true)
    }
}

// Preview Code
//@available(iOS 17.0, *)
//#Preview("LoginViewController") {
//    LoginViewController()
//}





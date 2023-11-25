//
//  SignUpViewController.swift
//  WBDN
//
//  Created by 박민서 on 11/25/23.
//

import UIKit
import SnapKit
import Then

class SignUpViewController: UIViewController {
    
    // "회원가입" 제목 라벨
    lazy var titleLabel: UILabel = UILabel().then {
        $0.text = "회원가입"
        $0.textColor = UIColor.white // 색 수정 필요
        $0.font = .systemFont(ofSize: 25, weight: .heavy)
    }
    
    lazy var image1: UIImageView = UIImageView().then {
        $0.image = UIImage(systemName: "seal.fill")
    }
    
    lazy var image1Label: UILabel = UILabel().then {
        $0.text = "1"
        $0.textColor = UIColor.black // 색 수정 필요
        $0.font = .systemFont(ofSize: 20)
    }
    
    // "아이디" 라벨
    lazy var idLabel: UILabel = UILabel().then {
        $0.text = "아이디"
        $0.textColor = UIColor.white // 색 수정 필요
        $0.font = .systemFont(ofSize: 20, weight: .heavy)
    }
    
    // ID 텍스트필드
    lazy var idTextField: UITextField = UITextField().then {
        $0.placeholder = "아이디"
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
        $0.backgroundColor = UIColor.white // 색 수정 필요
        
        // 좌우 여백 설정
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 10))
        
        $0.leftView = paddingView
        $0.leftViewMode = .always

        $0.rightView = paddingView
        $0.rightViewMode = .always
    }
    
    // id 중복확인 버튼
    lazy var idDupCheckButton: UIButton = UIButton().then {
        var titleAttr = AttributedString.init("중복확인")
        titleAttr.font = UIFont.systemFont(ofSize: 15)

        $0.configuration = .filled()
        $0.configuration?.attributedTitle = titleAttr
        $0.configuration?.baseForegroundColor = .black
        $0.configuration?.baseBackgroundColor = .yellow
        $0.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
    }
    
    // "아이디" 경고 라벨
    lazy var idWarnLabel: UILabel = UILabel().then {
        $0.text = "이미 존재하는 아이디입니다."
        $0.textColor = UIColor.red // 색 수정 필요
    }
    
    lazy var image2: UIImageView = UIImageView().then {
        $0.image = UIImage(systemName: "seal.fill")
    }
    
    lazy var image2Label: UILabel = UILabel().then {
        $0.text = "2"
        $0.textColor = UIColor.black // 색 수정 필요
        $0.font = .systemFont(ofSize: 20)
    }
    
    // "비밀번호" 라벨
    lazy var pwLabel: UILabel = UILabel().then {
        $0.text = "비밀번호"
        $0.textColor = UIColor.white // 색 수정 필요
        $0.font = .systemFont(ofSize: 20, weight: .heavy)
    }
    
    
    // PW 텍스트필드
    lazy var pwTextField: UITextField = UITextField().then {
        $0.placeholder = "비밀번호"
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
        $0.backgroundColor = UIColor.white // 색 수정 필요
        $0.isSecureTextEntry = true // 비밀번호 **** 표시
        
        // 좌우 여백 설정
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 10))
        
        $0.leftView = paddingView
        $0.leftViewMode = .always

        $0.rightView = paddingView
        $0.rightViewMode = .always
    }
    
    // PW 확인 텍스트필드
    lazy var pwCheckTextField: UITextField = UITextField().then {
        $0.placeholder = "비밀번호 확인"
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
        $0.backgroundColor = UIColor.white // 색 수정 필요
        $0.isSecureTextEntry = true // 비밀번호 **** 표시
        
        // 좌우 여백 설정
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 10))
        
        $0.leftView = paddingView
        $0.leftViewMode = .always

        $0.rightView = paddingView
        $0.rightViewMode = .always
    }
    
    // "비밀번호" 경고 라벨
    lazy var pwWarnLabel: UILabel = UILabel().then {
        $0.text = "비밀번호가 일치하지 않습니다."
        $0.textColor = UIColor.red // 색 수정 필요
    }
    
    lazy var image3: UIImageView = UIImageView().then {
        $0.image = UIImage(systemName: "seal.fill")
    }
    
    lazy var image3Label: UILabel = UILabel().then {
        $0.text = "3"
        $0.textColor = UIColor.black // 색 수정 필요
        $0.font = .systemFont(ofSize: 20)
    }
    
    // "닉네임" 라벨
    lazy var nickNameLabel: UILabel = UILabel().then {
        $0.text = "닉네임"
        $0.textColor = UIColor.white // 색 수정 필요
        $0.font = .systemFont(ofSize: 20, weight: .heavy)
    }
    
    // 닉네임 텍스트필드
    lazy var nickNameTextField: UITextField = UITextField().then {
        $0.placeholder = "닉네임"
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
        $0.backgroundColor = UIColor.white // 색 수정 필요
        $0.isSecureTextEntry = true // 비밀번호 **** 표시
        
        // 좌우 여백 설정
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 10))
        
        $0.leftView = paddingView
        $0.leftViewMode = .always

        $0.rightView = paddingView
        $0.rightViewMode = .always
    }
    
    // 닉네임 중복확인 버튼
    lazy var nickNameDupCheckButton: UIButton = UIButton().then {
        var titleAttr = AttributedString.init("중복확인")
        titleAttr.font = UIFont.systemFont(ofSize: 15)

        $0.configuration = .filled()
        $0.configuration?.attributedTitle = titleAttr
        $0.configuration?.baseForegroundColor = .black
        $0.configuration?.baseBackgroundColor = .yellow
        $0.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
    }
    
    // "닉네임" 경고 라벨
    lazy var nickNameWarnLabel: UILabel = UILabel().then {
        $0.text = "이미 사용중인 닉네임입니다."
        $0.textColor = UIColor.red // 색 수정 필요
    }
    
    // 회원가입 버튼
    lazy var signUpButton: UIButton = UIButton().then {
        
        var titleAttr = AttributedString.init("회원가입")
        titleAttr.font = UIFont.systemFont(ofSize: 18)

        $0.configuration = .filled()
        $0.configuration?.attributedTitle = titleAttr
        $0.configuration?.baseForegroundColor = .black
        $0.configuration?.baseBackgroundColor = .yellow
        $0.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20)
        
        $0.layer.cornerRadius = 30
        $0.clipsToBounds = true
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
        
        idDupCheckButton.addTarget(self, action: #selector(signUp), for: .touchUpInside)
        
        nickNameDupCheckButton.addTarget(self, action: #selector(signUp), for: .touchUpInside)
        
        signUpButton.addTarget(self, action: #selector(signUp), for: .touchUpInside)
    }
    
    // MARK: Delegate
    private func setUpDelegate() {
        idTextField.delegate = self
        pwTextField.delegate = self
        pwCheckTextField.delegate = self
        nickNameTextField.delegate = self
    }
    
    // MARK: addSubView
    private func setUpLayout() {
        [
            titleLabel,
            image1,
            image1Label,
            idLabel,
            idTextField,
            idDupCheckButton,
            idWarnLabel,
            image2,
            image2Label,
            pwLabel,
            pwTextField,
            pwCheckTextField,
            pwWarnLabel,
            image3,
            image3Label,
            nickNameLabel,
            nickNameTextField,
            nickNameDupCheckButton,
            nickNameWarnLabel,
            signUpButton
        ].forEach { self.view.addSubview($0)}
    }
    
    // MARK: setConstraint
    private func setUpConstraint() {
        
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        //----- 아이디
        
        image1.snp.makeConstraints {
            $0.left.equalToSuperview().offset(15)
            $0.top.equalTo(titleLabel.snp.bottom).offset(30)
            $0.size.equalTo(50)
        }
        
        image1Label.snp.makeConstraints {
            $0.center.equalTo(image1)
        }
        
        idLabel.snp.makeConstraints {
            $0.centerY.equalTo(image1)
            $0.left.equalTo(image1.snp.right).offset(10)
        }
        
        idTextField.snp.makeConstraints {
            $0.top.equalTo(image1.snp.bottom).offset(10)
            $0.left.equalTo(image1)
            $0.height.equalTo(50)
            $0.width.equalTo(250)
        }
        
        idDupCheckButton.snp.makeConstraints {
            $0.top.equalTo(idTextField)
            $0.left.equalTo(idTextField.snp.right).offset(10)
            $0.right.equalToSuperview().offset(-15)
            $0.height.equalTo(idTextField)
        }
        
        idWarnLabel.snp.makeConstraints {
            $0.top.equalTo(idTextField.snp.bottom).offset(10)
            $0.left.equalTo(idTextField)
        }
        
        //----- 비밀번호
        
        image2.snp.makeConstraints {
            $0.left.equalToSuperview().offset(15)
            $0.top.equalTo(idWarnLabel.snp.bottom).offset(20)
            $0.size.equalTo(50)
        }
        
        image2Label.snp.makeConstraints {
            $0.center.equalTo(image2)
        }
        
        pwLabel.snp.makeConstraints {
            $0.centerY.equalTo(image2)
            $0.left.equalTo(image2.snp.right).offset(10)
        }
        
        pwTextField.snp.makeConstraints {
            $0.top.equalTo(image2.snp.bottom).offset(10)
            $0.left.equalTo(image2)
            $0.right.equalToSuperview().offset(-15)
            $0.height.equalTo(50)
        }
        
        pwCheckTextField.snp.makeConstraints {
            $0.top.equalTo(pwTextField.snp.bottom).offset(10)
            $0.left.equalTo(pwTextField)
            $0.right.equalToSuperview().offset(-15)
            $0.height.equalTo(50)
        }
        
        pwWarnLabel.snp.makeConstraints {
            $0.top.equalTo(pwCheckTextField.snp.bottom).offset(10)
            $0.left.equalTo(pwCheckTextField)
        }
        
        //----- 아이디
        
        image3.snp.makeConstraints {
            $0.left.equalToSuperview().offset(15)
            $0.top.equalTo(pwWarnLabel.snp.bottom).offset(30)
            $0.size.equalTo(50)
        }
        
        image3Label.snp.makeConstraints {
            $0.center.equalTo(image3)
        }
        
        nickNameLabel.snp.makeConstraints {
            $0.centerY.equalTo(image3)
            $0.left.equalTo(image3.snp.right).offset(10)
        }
        
        nickNameTextField.snp.makeConstraints {
            $0.top.equalTo(image3.snp.bottom).offset(10)
            $0.left.equalTo(image3)
            $0.height.equalTo(50)
            $0.width.equalTo(250)
        }
        
        nickNameDupCheckButton.snp.makeConstraints {
            $0.top.equalTo(nickNameTextField)
            $0.left.equalTo(nickNameTextField.snp.right).offset(10)
            $0.right.equalToSuperview().offset(-15)
            $0.height.equalTo(nickNameTextField)
        }
        
        nickNameWarnLabel.snp.makeConstraints {
            $0.top.equalTo(nickNameTextField.snp.bottom).offset(10)
            $0.left.equalTo(nickNameTextField)
        }
        
        //------회원가입 버튼
        
        signUpButton.snp.makeConstraints {
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-20)
            $0.height.equalTo(60)
            $0.left.equalToSuperview().offset(15)
            $0.right.equalToSuperview().offset(-15)
        }
    }
    
}

extension SignUpViewController: UITextFieldDelegate {
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
#Preview("SignUpViewController") {
    SignUpViewController()
}





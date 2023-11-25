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
//        $0.font = .systemFont(ofSize: 25, weight: .heavy)
        $0.font = .pretendard(size: 21, weight: .semiBold)
    }
    
    lazy var image1: UIImageView = UIImageView().then {
        $0.image = UIImage.yelloStar
        $0.tintColor = .yellow
    }
    
    lazy var image1Label: UILabel = UILabel().then {
        $0.text = "1"
        $0.textColor = UIColor.black // 색 수정 필요
        $0.font = .pretendard(size: 17, weight: .semiBold)
    }
    
    // "아이디" 라벨
    lazy var idLabel: UILabel = UILabel().then {
        $0.text = "아이디"
        $0.textColor = UIColor.white // 색 수정 필요
        $0.font = .pretendard(size: 17, weight: .semiBold)
    }
    
    // ID 텍스트필드
    lazy var idTextField: UITextField = UITextField().then {
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
        $0.backgroundColor = .customMidGray
        $0.textColor = .customLightGray
        $0.font = .pretendard(size: 15, weight: .medium)
        
        // Placeholder 텍스트 속성 설정
        let placeholderText = "아이디"
        let attributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.foregroundColor: UIColor.customLightGray,
        ]

        let attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: attributes)
        $0.attributedPlaceholder = attributedPlaceholder
        
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
        titleAttr.font = .pretendard(size: 17, weight: .semiBold)

        $0.configuration = .filled()
        $0.configuration?.attributedTitle = titleAttr
        $0.configuration?.baseForegroundColor = .black
        $0.configuration?.baseBackgroundColor = .customYellow
        $0.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
    }
    
    // "아이디" 경고 라벨
    lazy var idWarnLabel: UILabel = UILabel().then {
        $0.text = "한글/영문/숫자 중 조합하여 2자~20자 입력"
        $0.textColor = UIColor.white // 색 수정 필요
        $0.font = .pretendard(size: 11, weight: .regular)
    }
    
    lazy var image2: UIImageView = UIImageView().then {
        $0.image = UIImage.yelloStar
    }
    
    lazy var image2Label: UILabel = UILabel().then {
        $0.text = "2"
        $0.textColor = UIColor.black // 색 수정 필요
        $0.font = .pretendard(size: 17, weight: .semiBold)
    }
    
    // "비밀번호" 라벨
    lazy var pwLabel: UILabel = UILabel().then {
        $0.text = "비밀번호"
        $0.textColor = UIColor.white // 색 수정 필요
        $0.font = .pretendard(size: 17, weight: .semiBold)
    }
    
    
    // PW 텍스트필드
    lazy var pwTextField: UITextField = UITextField().then {
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
        $0.isSecureTextEntry = true // 비밀번호 **** 표시
        $0.backgroundColor = .customMidGray
        $0.textColor = .customLightGray
        $0.font = .pretendard(size: 15, weight: .medium)
        
        // Placeholder 텍스트 속성 설정
        let placeholderText = "비밀번호"
        let attributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.foregroundColor: UIColor.customLightGray,
        ]

        let attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: attributes)
        $0.attributedPlaceholder = attributedPlaceholder
        
        // 좌우 여백 설정
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 10))
        
        $0.leftView = paddingView
        $0.leftViewMode = .always

        $0.rightView = paddingView
        $0.rightViewMode = .always
    }
    
    // PW 확인 텍스트필드
    lazy var pwCheckTextField: UITextField = UITextField().then {
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
        $0.backgroundColor = UIColor.white // 색 수정 필요
        $0.isSecureTextEntry = true // 비밀번호 **** 표시
        $0.backgroundColor = .customMidGray
        $0.textColor = .customLightGray
        $0.font = .pretendard(size: 15, weight: .medium)
        
        // Placeholder 텍스트 속성 설정
        let placeholderText = "비밀번호 확인"
        let attributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.foregroundColor: UIColor.customLightGray,
        ]

        let attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: attributes)
        $0.attributedPlaceholder = attributedPlaceholder
        
        // 좌우 여백 설정
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 10))
        
        $0.leftView = paddingView
        $0.leftViewMode = .always

        $0.rightView = paddingView
        $0.rightViewMode = .always
    }
    
    // "비밀번호" 경고 라벨
    lazy var pwWarnLabel: UILabel = UILabel().then {
        $0.text = "한글/영문/숫자 중 조합하여 4자~20자 입력"
        $0.textColor = UIColor.white // 색 수정 필요
        $0.font = .systemFont(ofSize: 11)
    }
    
    lazy var image3: UIImageView = UIImageView().then {
        $0.image = UIImage.yelloStar
    }
    
    lazy var image3Label: UILabel = UILabel().then {
        $0.text = "3"
        $0.textColor = UIColor.black // 색 수정 필요
        $0.font = .pretendard(size: 17, weight: .semiBold)
    }
    
    // "닉네임" 라벨
    lazy var nickNameLabel: UILabel = UILabel().then {
        $0.text = "닉네임"
        $0.textColor = UIColor.white // 색 수정 필요
        $0.font = .pretendard(size: 17, weight: .semiBold)
    }
    
    // 닉네임 텍스트필드
    lazy var nickNameTextField: UITextField = UITextField().then {
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
        $0.backgroundColor = .customMidGray
        $0.textColor = .customLightGray
        $0.font = .pretendard(size: 15, weight: .medium)
        
        // Placeholder 텍스트 속성 설정
        let placeholderText = "닉네임"
        let attributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.foregroundColor: UIColor.customLightGray,
        ]

        let attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: attributes)
        $0.attributedPlaceholder = attributedPlaceholder
        
        // 좌우 여백 설정
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 10))
        
        $0.leftView = paddingView
        $0.leftViewMode = .always

        $0.rightView = paddingView
        $0.rightViewMode = .always
    }
    
    // 닉네임 중복확인 버튼
    lazy var nickNameDupCheckButton: UIButton = UIButton().then {
        var titleAttr = AttributedString.init("중복확인")
        titleAttr.font = .pretendard(size: 17, weight: .semiBold)

        $0.configuration = .filled()
        $0.configuration?.attributedTitle = titleAttr
        $0.configuration?.baseForegroundColor = .black
        $0.configuration?.baseBackgroundColor = .customYellow
        $0.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
    }
    
    // "닉네임" 경고 라벨
    lazy var nickNameWarnLabel: UILabel = UILabel().then {
        $0.text = "한글/영문/숫자 중 조합하여 2자~20자 입력"
        $0.textColor = UIColor.white // 색 수정 필요
        $0.font = .pretendard(size: 11, weight: .regular)
    }
    
    // 회원가입 버튼
    lazy var signUpButton: UIButton = UIButton().then {
        
        var titleAttr = AttributedString.init("회원가입")
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
        self.view.backgroundColor = .customNavy
        
        setUpView()
        setUpDelegate()
        setUpLayout()
        setUpConstraint()
        
        
    }//: viewDidLoad()
    
    // MARK: set component config
    private func setUpView() {
        
        idDupCheckButton.addTarget(self, action: #selector(idDupCheck), for: .touchUpInside)
        
        nickNameDupCheckButton.addTarget(self, action: #selector(nickNameDupCheck), for: .touchUpInside)
        
        signUpButton.addTarget(self, action: #selector(signUp), for: .touchUpInside)
    }
    
    // MARK: Delegate
    private func setUpDelegate() {
        pwTextField.delegate = self
        pwCheckTextField.delegate = self
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
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(12)
        }
        
        //----- 아이디
        
        image1.snp.makeConstraints {
            $0.left.equalToSuperview().offset(15)
            $0.top.equalTo(titleLabel.snp.bottom).offset(30)
            $0.size.equalTo(40)
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
            $0.size.equalTo(40)
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
            $0.size.equalTo(40)
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
            $0.height.equalTo(55)
            $0.left.equalToSuperview().offset(15)
            $0.right.equalToSuperview().offset(-15)
        }
    }
    
}

extension SignUpViewController: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // 텍스트 필드의 값이 변경될 때마다 호출됩니다.
    func textFieldDidChangeSelection(_ textField: UITextField) {
        
        if self.pwTextField.text == "" && self.pwCheckTextField.text == "" {
            self.pwWarnLabel.textColor = .white
            self.pwWarnLabel.text = "한글/영문/숫자 중 조합하여 4자~20자 입력"
        }
        else if self.pwTextField.text == self.pwCheckTextField.text {
            print("비밀번호 일치")
            self.pwWarnLabel.textColor = .customYellow
            self.pwWarnLabel.text = "비밀번호가 일치합니다."
        }
        else {
            self.pwWarnLabel.textColor = .red
            self.pwWarnLabel.text = "비밀번호가 일치하지 않습니다."
        }
    }
            
    
    @objc func idDupCheck() {
        let ID = self.idTextField.text
        guard let id = ID else { return }
        idWarnLabel.text = "사용 가능한 아이디입니다."
        idWarnLabel.textColor = .customYellow
        
    }
    
    @objc func nickNameDupCheck() {
        let nickName = self.nickNameTextField.text
        nickNameWarnLabel.text = "사용 가능한 닉네임입니다."
        nickNameWarnLabel.textColor = .customYellow
    }
    
    @objc func signUp() {
        print("go to signUp")
        guard let id = idTextField.text else { return }
        guard let pw = pwTextField.text else { return }
        guard let nickname = nickNameTextField.text else { return }
        
        // 대충 로그인 API 호출
        Task {
            let response = try await NetworkService.shared.request(.signUp(dto: .init(loginId: id, password: pw, nickname: nickname)), type: BaseResponse<SignUpResponse>.self)
            
            guard let data = response.result?.memberId else { return }
            
            let viewController = WelcomeViewController()
            viewController.goToLoginCompletion = {
                self.dismiss(animated: true)
            }
            viewController.modalPresentationStyle = .fullScreen
            present(viewController, animated: true, completion: nil)
        }
    }
}

// Preview Code
//@available(iOS 17.0, *)
//#Preview("SignUpViewController") {
//    SignUpViewController()
//}





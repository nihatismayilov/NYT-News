//
//  SignInVC.swift
//  presentation
//
//  Created by Nihad Ismayilov on 18.09.22.
//

import UIKit
import SnapKit
import Firebase

public class SignInVC: BaseVC<SignInVM> {
    // MARK: - Variables
    
//    let database = Firestore.firestore() 
    
    // MARK: - UI Components
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        self.view.addSubview(scroll)
        scroll.showsVerticalScrollIndicator = false
        scroll.showsHorizontalScrollIndicator = false
        
        return scroll
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        self.scrollView.addSubview(view)

        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let lbl = UILabel()
        self.contentView.addSubview(lbl)
        lbl.textColor = Asset.Colors.textColor.color
        lbl.font = UIFont(font: FontFamily.NunitoSans.extraBold, size: 32)
        
        lbl.text = "Login"
        
        return lbl
    }()
    
    lazy var emailStack: UIStackView = {
        let stack = UIStackView()
        self.contentView.addSubview(stack)
        stack.axis = .vertical
        stack.spacing = 2
        stack.distribution = .equalSpacing
        
        return stack
    }()
    
    lazy var emailLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Email"
        lbl.textColor = Asset.Colors.accentColor.color
        lbl.font = UIFont(font: FontFamily.NunitoSans.bold, size: 16)
        
        return lbl
    }()
    
    lazy var emailTF: UITextField = {
        let tf = UITextField()
        tf.textColor = Asset.Colors.textColor.color
        tf.keyboardType = .emailAddress
        tf.autocapitalizationType = .none
        
        return tf
    }()
    
    lazy var emailView: UIView = {
        let view = UIView()
        self.contentView.addSubview(view)
        view.backgroundColor = .lightGray
        
        return view
    }()
    
    lazy var passwordStack: UIStackView = {
        let stack = UIStackView()
        self.contentView.addSubview(stack)
        stack.axis = .vertical
        stack.spacing = 2
        stack.distribution = .equalSpacing
        
        return stack
    }()
    
    lazy var passwordLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Password"
        lbl.textColor = Asset.Colors.accentColor.color
        lbl.font = UIFont(font: FontFamily.NunitoSans.bold, size: 16)
        
        return lbl
    }()
    
    lazy var passwordTF: UITextField = {
        let tf = UITextField()
        tf.textColor = Asset.Colors.textColor.color
        tf.isSecureTextEntry = true
        tf.autocapitalizationType = .none
        
        return tf
    }()
    
    let rightButton = UIButton(type: .system)
    
    lazy var passwordView: UIView = {
        let view = UIView()
        self.contentView.addSubview(view)
        view.backgroundColor = .lightGray
        
        return view
    }()
    
    lazy var loginButton: UIButton = {
        let btn = UIButton()
        self.contentView.addSubview(btn)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.backgroundColor = Asset.Colors.accentColor.color
        btn.layer.cornerRadius = 24
        btn.titleLabel?.font = UIFont(font: FontFamily.NunitoSans.bold, size: 16)
        btn.setTitle("Sign In", for: .normal)
        btn.addTarget(self, action: #selector(onLoginTapped), for: .touchUpInside)
        
        return btn
    }()
    
    lazy var signUpLabel: UILabel = {
        let lbl = UILabel()
        self.contentView.addSubview(lbl)
        lbl.font = UIFont(font: FontFamily.NunitoSans.semiBold, size: 12)
        lbl.textColor = .lightGray
        
        var firstAttributedString = NSMutableAttributedString()
        firstAttributedString = NSMutableAttributedString(string: "Don't have an account? Sign Up")
        firstAttributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: Asset.Colors.accentColor.color as Any, range: NSRange(location: 23, length: 7))
        
        var secondAS = NSMutableAttributedString()
        secondAS = firstAttributedString
        secondAS.addAttribute(NSAttributedString.Key.font, value: UIFont(font: FontFamily.NunitoSans.bold, size: 12)  as Any, range: NSRange(location: 23, length: 7))
        
        lbl.isUserInteractionEnabled = true
        let signUpGesture = UITapGestureRecognizer(target: self, action: #selector(onSignUpTapped))
        lbl.addGestureRecognizer(signUpGesture)
        
        lbl.attributedText = secondAS
        
        return lbl
    }()
    
    // MARK: - Parent Delegate
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Asset.Colors.tabbarColor.color
        self.setupUI()
        self.rightView()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        if let theme = APPDefaults.getString(key: "theme") {
            switch theme {
            case "Light":
                UIApplication.shared.windows.first!.overrideUserInterfaceStyle = .light
            case "Dark":
                UIApplication.shared.windows.first!.overrideUserInterfaceStyle = .dark
            default:
                break
            }
        }
    }
    
    // MARK: - Functions
    @objc func onLoginTapped() {
        guard let email = emailTF.text, emailTF.hasText,
              let password = passwordTF.text, passwordTF.hasText else {
            self.displayAlertMessage(messageToDisplay: "Some fields are empty, please fill them before continuing", title: "Error!")
            return
            // show alert here
        }
        
        self.addActivity(frame: self.view.frame)
        
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            guard error == nil else {
                self?.displayAlertMessage(messageToDisplay: error?.localizedDescription ?? "Unexpected error occured", title: "Error!")
                self?.removeActivity()
                return
            }
                        
            let vc = self?.router?.tabbarVC()
            vc?.modalPresentationStyle = .fullScreen
            self?.present(vc!, animated: true)
        }
    }
    
    func rightView() {
        rightButton.frame = CGRect(x: CGFloat(passwordTF.frame.size.width - 25), y: CGFloat(0), width: CGFloat(25), height: CGFloat(25))
        rightButton.setImage(Asset.Media.icHidden.image, for: .normal)
        rightButton.addTarget(self, action: #selector(onHideShowTapped), for: .touchUpInside)
        passwordTF.rightView = rightButton
        passwordTF.rightViewMode = .always
    }
    @objc func onHideShowTapped() {
        self.rightButton.setImage(self.passwordTF.isSecureTextEntry == false ? Asset.Media.icHidden.image: Asset.Media.icShown.image, for: .normal)
        
        self.passwordTF.isSecureTextEntry.toggle()
    }
    
    @objc func onSignUpTapped(_ gesture: UITapGestureRecognizer) {
        guard let text = self.signUpLabel.text else { return }
        let conditionsRange = (text as NSString).range(of: "Sign Up")
        let cancellationRange = (text as NSString).range(of: "Don't have an account? ")
        
        if gesture.didTapAttributedTextInLabel(label: self.signUpLabel, inRange: conditionsRange) {
            let vc = self.router?.signUpVC()
            vc?.modalPresentationStyle = .fullScreen
            self.present(vc!, animated: true)
        } else if gesture.didTapAttributedTextInLabel(label: self.signUpLabel, inRange: cancellationRange) {
            // empty
        }
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension SignInVC {
    func setupUI() {
        self.scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        self.contentView.snp.makeConstraints { make in
            make.edges.equalTo(self.scrollView.snp.edges)
            make.width.equalTo(self.scrollView.snp.width)
        }
        
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.contentView.safeAreaLayoutGuide.snp.top).offset(56)
            make.left.equalTo(self.contentView.snp.left).offset(16)
        }
        
        emailStack.addArrangedSubview(emailLabel)
        emailStack.addArrangedSubview(emailTF)
        self.emailStack.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(48)
            make.left.equalTo(self.contentView.snp.left).offset(24)
            make.right.equalTo(self.contentView.snp.right).offset(-24)
        }
        emailTF.snp.makeConstraints { make in
            make.height.equalTo(32)
        }
        self.emailView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.top.equalTo(self.emailStack.snp.bottom)
            make.left.equalTo(self.emailStack.snp.left)
            make.right.equalTo(self.emailStack.snp.right)
        }
        
        passwordStack.addArrangedSubview(passwordLabel)
        passwordStack.addArrangedSubview(passwordTF)
        self.passwordStack.snp.makeConstraints { make in
            make.top.equalTo(self.emailStack.snp.bottom).offset(24)
            make.left.equalTo(self.contentView.snp.left).offset(24)
            make.right.equalTo(self.contentView.snp.right).offset(-24)
        }
        passwordTF.snp.makeConstraints { make in
            make.height.equalTo(32)
        }
        self.passwordView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.top.equalTo(self.passwordStack.snp.bottom)
            make.left.equalTo(self.passwordStack.snp.left)
            make.right.equalTo(self.passwordStack.snp.right)
        }
        self.rightButton.snp.makeConstraints { make in
            make.width.height.equalTo(24)
        }
        
        loginButton.snp.makeConstraints { make in
            make.height.equalTo(48)
            make.top.equalTo(self.passwordStack.snp.bottom).offset(64)
            make.left.equalTo(self.contentView.snp.left).offset(24)
            make.right.equalTo(self.contentView.snp.right).offset(-24)
        }
        
        self.signUpLabel.snp.makeConstraints { make in
            make.centerX.equalTo(self.loginButton.snp.centerX)
            make.top.equalTo(self.loginButton.snp.bottom).offset(16)
            make.bottom.lessThanOrEqualTo(self.contentView.snp.bottom).offset(-32)
        }
    }
}

//
//  SignInVC.swift
//  presentation
//
//  Created by Nihad Ismayilov on 18.09.22.
//

import UIKit
import SnapKit
import Firebase
import Lottie

public class SignInVC: BaseVC<SignInVM> {
    // MARK: - Variables
        
    var animationView = AnimationView()
    var height: CGFloat? = nil
    
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
    
    lazy var emailImage: UIImageView = {
        let img = UIImageView()
        self.contentView.addSubview(img)
        img.tintColor = Asset.Colors.redWithDark.color
        img.image = Asset.Media.icMail.image
        
        return img
    }()
    
    lazy var emailTF: UITextField = {
        let tf = UITextField()
        self.contentView.addSubview(tf)
        tf.textColor = Asset.Colors.textColor.color
        tf.keyboardType = .emailAddress
        tf.autocapitalizationType = .none
        tf.placeholder = "Email"
        tf.delegate = self
        tf.autocorrectionType = .no
        tf.autocapitalizationType = .none
        
        return tf
    }()
    
    lazy var emailView: UIView = {
        let view = UIView()
        self.contentView.addSubview(view)
        view.backgroundColor = .lightGray
        
        return view
    }()
    
    lazy var passwordImage: UIImageView = {
        let img = UIImageView()
        self.contentView.addSubview(img)
        img.tintColor = Asset.Colors.redWithDark.color
        img.image = Asset.Media.icPassword.image
        
        return img
    }()
    
    lazy var passwordTF: UITextField = {
        let tf = UITextField()
        self.contentView.addSubview(tf)
        tf.textColor = Asset.Colors.textColor.color
        tf.isSecureTextEntry = true
        tf.autocapitalizationType = .none
        tf.placeholder = "Password"
        tf.delegate = self
        tf.autocorrectionType = .no
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
        
        btn.layer.shadowOffset = CGSize(width: 0, height: 0)
        btn.layer.shadowRadius = 4
        btn.layer.shadowColor = Asset.Colors.shadowColor.color.cgColor
        btn.layer.shadowOpacity = 0.7
        
        return btn
    }()
    
    lazy var signUpLabel: UILabel = {
        let lbl = UILabel()
        self.contentView.addSubview(lbl)
        lbl.font = UIFont(font: FontFamily.NunitoSans.semiBold, size: 14)
        lbl.textColor = .lightGray
        
        var firstAttributedString = NSMutableAttributedString()
        firstAttributedString = NSMutableAttributedString(string: "Not a member? Sign up")
        firstAttributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: Asset.Colors.accentColor.color as Any, range: NSRange(location: 14, length: 7))
        
        var secondAS = NSMutableAttributedString()
        secondAS = firstAttributedString
        secondAS.addAttribute(NSAttributedString.Key.font, value: UIFont(font: FontFamily.NunitoSans.bold, size: 14)  as Any, range: NSRange(location: 14, length: 7))
        
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
        self.view.addSubview(animationView)
        self.setupUI()
        self.rightView()
        
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)))
        tapGesture.cancelsTouchesInView = false
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
            self.displayAlertMessage(messageToDisplay: "", title: "Fields cannot be left empty")
            return
        }
        
        self.addActivity(frame: self.view.frame)
        
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            guard error == nil else {
                self?.displayAlertMessage(messageToDisplay: error?.localizedDescription ?? "", title: "Unexpected error occured")
                self?.removeActivity()
                return
            }
                        
            let vc = self?.router?.tabbarVC()
            vc?.modalPresentationStyle = .fullScreen
            self?.present(vc!, animated: true)
        }
    }
    
    func rightView() {
        rightButton.frame = CGRect(x: CGFloat(passwordTF.frame.size.width - 25), y: CGFloat(-5), width: CGFloat(25), height: CGFloat(25))
        rightButton.tintColor = Asset.Colors.redWithDark.color
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
        let conditionsRange = (text as NSString).range(of: "Sign up")
        let cancellationRange = (text as NSString).range(of: "Not a member? ")
        
        if gesture.didTapAttributedTextInLabel(label: self.signUpLabel, inRange: conditionsRange) {
            let vc = self.router?.signUpVC()
            vc?.modalPresentationStyle = .fullScreen
            self.present(vc!, animated: true)
        } else if gesture.didTapAttributedTextInLabel(label: self.signUpLabel, inRange: cancellationRange) {
            // empty
        }
    }
}

extension SignInVC: UITextFieldDelegate {
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == self.emailTF {
            self.emailView.backgroundColor = Asset.Colors.accentColor.color
        } else if textField == self.passwordTF {
            self.passwordView.backgroundColor = Asset.Colors.accentColor.color
        }
        self.contentView.snp.makeConstraints { make in
            make.height.equalTo(250 + self.contentView.frame.size.height)
        }
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == self.emailTF {
            self.emailView.backgroundColor = .lightGray
        } else if textField == self.passwordTF {
            self.passwordView.backgroundColor = .lightGray
        }
//        self.contentView.snp.makeConstraints { make in
//            make.height.equalTo(self.contentView.frame.size.height - 250)
//        }
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}

extension SignInVC {
    func setupUI() {
        animationView.snp.makeConstraints { make in
            make.edges.equalTo(self.view.snp.edges)
        }
        
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
        emailImage.snp.makeConstraints { make in
            make.width.height.equalTo(20)
            make.top.equalTo(self.titleLabel.snp.bottom).offset(48)
            make.left.equalTo(self.contentView.snp.left).offset(24)
        }
        emailTF.snp.makeConstraints { make in
            make.height.equalTo(32)
            make.centerY.equalTo(self.emailImage.snp.centerY)
            make.left.equalTo(self.emailImage.snp.right).offset(8)
            make.right.equalTo(self.contentView.snp.right).offset(-24)
        }
        self.emailView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.top.equalTo(self.emailTF.snp.bottom)
            make.left.equalTo(self.emailTF.snp.left)
            make.right.equalTo(self.emailTF.snp.right)
        }
        
        passwordImage.snp.makeConstraints { make in
            make.width.height.equalTo(24)
            make.top.equalTo(self.emailView.snp.bottom).offset(48)
            make.left.equalTo(self.contentView.snp.left).offset(24)
        }
        passwordTF.snp.makeConstraints { make in
            make.height.equalTo(32)
            make.centerY.equalTo(self.passwordImage.snp.centerY)
            make.left.equalTo(self.passwordImage.snp.right).offset(8)
            make.right.equalTo(self.contentView.snp.right).offset(-24)
        }
        self.passwordView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.top.equalTo(self.passwordTF.snp.bottom)
            make.left.equalTo(self.passwordTF.snp.left)
            make.right.equalTo(self.passwordTF.snp.right)
        }
        self.rightButton.snp.makeConstraints { make in
            make.width.height.equalTo(24)
        }
        
        loginButton.snp.makeConstraints { make in
            make.height.equalTo(48)
            make.top.equalTo(self.passwordView.snp.bottom).offset(64)
            make.left.equalTo(self.contentView.snp.left).offset(24)
            make.right.equalTo(self.contentView.snp.right).offset(-24)
        }
        
        self.signUpLabel.snp.makeConstraints { make in
            make.centerX.equalTo(self.loginButton.snp.centerX)
            make.top.equalTo(self.loginButton.snp.bottom).offset(24)
            make.bottom.lessThanOrEqualTo(self.contentView.snp.bottom).offset(-32)
        }
    }
}

extension SignInVC {
    func startAnimation() {
        animationView.animation = Animation.named("loginBack2")
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()
        animationView.layer.cornerRadius = 16

    }
}

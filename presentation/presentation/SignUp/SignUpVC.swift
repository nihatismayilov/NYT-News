//
//  SignUpVC.swift
//  presentation
//
//  Created by Nihad Ismayilov on 20.09.22.
//

import Foundation
import UIKit
import SnapKit
import Firebase
import FirebaseFirestore

public class SignUpVC: BaseVC<SignUpVM> {
    
    // MARK: - Variables
//    let database = Firestore.firestore()
    
    let passwordRightButton = UIButton(type: .system)
    let rePasswordRightButton = UIButton(type: .system)
    
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
        
        lbl.text = "Sign Up"
        
        return lbl
    }()
    
    lazy var nameStack: UIStackView = {
        let stack = UIStackView()
        self.contentView.addSubview(stack)
        stack.axis = .vertical
        stack.spacing = 2
        stack.distribution = .equalSpacing
        
        return stack
    }()
    
    lazy var nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Name"
        lbl.textColor = Asset.Colors.accentColor.color
        lbl.font = UIFont(font: FontFamily.NunitoSans.bold, size: 16)
        
        return lbl
    }()
    
    lazy var nameTF: UITextField = {
        let tf = UITextField()
        tf.textColor = Asset.Colors.textColor.color
        
        return tf
    }()
    
    lazy var nameView: UIView = {
        let view = UIView()
        self.contentView.addSubview(view)
        view.backgroundColor = .lightGray
        
        return view
    }()
    
    lazy var surnameStack: UIStackView = {
        let stack = UIStackView()
        self.contentView.addSubview(stack)
        stack.axis = .vertical
        stack.spacing = 2
        stack.distribution = .equalSpacing
        
        return stack
    }()
    
    lazy var surnameLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Surname"
        lbl.textColor = Asset.Colors.accentColor.color
        lbl.font = UIFont(font: FontFamily.NunitoSans.bold, size: 16)
        
        return lbl
    }()
    
    lazy var surnameTF: UITextField = {
        let tf = UITextField()
        tf.textColor = Asset.Colors.textColor.color
        
        return tf
    }()
    
    lazy var surnameView: UIView = {
        let view = UIView()
        self.contentView.addSubview(view)
        view.backgroundColor = .lightGray
        
        return view
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
    
    lazy var passwordView: UIView = {
        let view = UIView()
        self.contentView.addSubview(view)
        view.backgroundColor = .lightGray
        
        return view
    }()
    
    lazy var rePasswordStack: UIStackView = {
        let stack = UIStackView()
        self.contentView.addSubview(stack)
        stack.axis = .vertical
        stack.spacing = 2
        stack.distribution = .equalSpacing
        
        return stack
    }()
    
    lazy var rePasswordLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Re-enter your Password"
        lbl.textColor = Asset.Colors.accentColor.color
        lbl.font = UIFont(font: FontFamily.NunitoSans.bold, size: 16)
        
        return lbl
    }()
    
    lazy var reenterPasswordTF: UITextField = {
        let tf = UITextField()
        tf.textColor = Asset.Colors.textColor.color
        tf.isSecureTextEntry = true
        tf.autocapitalizationType = .none
        
        return tf
    }()
    
    lazy var rePasswordView: UIView = {
        let view = UIView()
        self.contentView.addSubview(view)
        view.backgroundColor = .lightGray
        
        return view
    }()
    
    lazy var signUpButton: UIButton = {
        let btn = UIButton()
        self.contentView.addSubview(btn)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.backgroundColor = Asset.Colors.accentColor.color
        btn.layer.cornerRadius = 24
        btn.titleLabel?.font = UIFont(font: FontFamily.NunitoSans.bold, size: 16)
        btn.setTitle("Create Account", for: .normal)
        btn.addTarget(self, action: #selector(onCreateTapped), for: .touchUpInside)
        
        return btn
    }()
    
    lazy var signInLabel: UILabel = {
        let lbl = UILabel()
        self.contentView.addSubview(lbl)
        lbl.font = UIFont(font: FontFamily.NunitoSans.semiBold, size: 12)
        lbl.textColor = .lightGray
        
        var firstAttributedString = NSMutableAttributedString()
        firstAttributedString = NSMutableAttributedString(string: "Already have an account? Sign In")
        firstAttributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: Asset.Colors.accentColor.color as Any, range: NSRange(location: 25, length: 7))
        
        var secondAS = NSMutableAttributedString()
        secondAS = firstAttributedString
        secondAS.addAttribute(NSAttributedString.Key.font, value: UIFont(font: FontFamily.NunitoSans.bold, size: 12)  as Any, range: NSRange(location: 25, length: 7))
        
        lbl.isUserInteractionEnabled = true
        let signUpGesture = UITapGestureRecognizer(target: self, action: #selector(onSignInTapped))
        lbl.addGestureRecognizer(signUpGesture)
        
        lbl.attributedText = secondAS
        
        return lbl
    }()
    
    // MARK: - Parent Delegate
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Asset.Colors.tabbarColor.color
        self.setupUI()
//        self.rightView()
        
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
    @objc func onCreateTapped() {
        guard let mail = emailTF.text, emailTF.hasText,
              let password = passwordTF.text, passwordTF.hasText,
              let reenterPassword = reenterPasswordTF.text, reenterPasswordTF.hasText,
              let name = nameTF.text, nameTF.hasText, let surname = surnameTF.text, surnameTF.hasText else {
            self.displayAlertMessage(messageToDisplay: "Some fields are empty, please fill them before continuing", title: "Error!")
            self.removeActivity()
            return
        }
        
        if password != reenterPassword {
            self.displayAlertMessage(messageToDisplay: "Passwords do not match", title: "Error!")
            self.removeActivity()
        } else {
            self.addActivity(frame: self.view.frame)
            Firebase.Auth.auth().createUser(withEmail: mail, password: password) { [weak self] rsult, error in
                guard error == nil else {
                    self?.displayAlertMessage(messageToDisplay: error?.localizedDescription ?? "Unrecognized error occured", title: "Error!")
                    self?.removeActivity()
                    return
                }
                
                if let currentUser = Firebase.Auth.auth().currentUser {
                    self?.saveProfile(id: currentUser.uid, name: name, surname: surname, mail: mail, password: password)
                }
            }
        }
        
    }
    
    @objc func onSignInTapped(_ gesture: UITapGestureRecognizer) {
        guard let text = self.signInLabel.text else { return }
        let conditionsRange = (text as NSString).range(of: "Sign In")
        let cancellationRange = (text as NSString).range(of: "Already have an account? ")
        
        if gesture.didTapAttributedTextInLabel(label: self.signInLabel, inRange: conditionsRange) {
            self.dismiss(animated: true)
        } else if gesture.didTapAttributedTextInLabel(label: self.signInLabel, inRange: cancellationRange) {
            // empty
        }
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func saveProfile(id: String ,name: String, surname: String, mail: String, password: String) {
        if let uuid = Auth.auth().currentUser?.uid {
            let nameRef = database.document("\(uuid)/name")
            nameRef.setData(["name": name])
            
            let surnameRef = database.document("\(uuid)/surname")
            surnameRef.setData(["surname": surname])
            
            let mailRef = database.document("\(uuid)/mail")
            mailRef.setData(["mail": mail])
            
            let passRef = database.document("\(uuid)/password")
            passRef.setData(["password": password])
            
            self.removeActivity()
            let vc = self.router?.tabbarVC()
            vc?.modalPresentationStyle = .fullScreen
            self.present(vc!, animated: true)
        }
    }
    
    func passwordRightView() {
        passwordRightButton.frame = CGRect(x: CGFloat(passwordTF.frame.size.width - 25), y: CGFloat(0), width: CGFloat(25), height: CGFloat(25))
        passwordRightButton.setImage(Asset.Media.icHidden.image, for: .normal)
        passwordRightButton.addTarget(self, action: #selector(onHideShowTappedForPassword), for: .touchUpInside)
        passwordTF.rightView = passwordRightButton
        passwordTF.rightViewMode = .always
    }
    @objc func onHideShowTappedForPassword() {
        self.passwordRightButton.setImage(self.passwordTF.isSecureTextEntry == false ? Asset.Media.icHidden.image: Asset.Media.icShown.image, for: .normal)
        
        self.passwordTF.isSecureTextEntry.toggle()
    }
    
    func rePasswordRightView() {
        rePasswordRightButton.frame = CGRect(x: CGFloat(reenterPasswordTF.frame.size.width - 25), y: CGFloat(0), width: CGFloat(25), height: CGFloat(25))
        rePasswordRightButton.setImage(Asset.Media.icHidden.image, for: .normal)
        rePasswordRightButton.addTarget(self, action: #selector(onHideShowTappedForRePassword), for: .touchUpInside)
        reenterPasswordTF.rightView = rePasswordRightButton
        reenterPasswordTF.rightViewMode = .always
    }
    @objc func onHideShowTappedForRePassword() {
        self.rePasswordRightButton.setImage(self.reenterPasswordTF.isSecureTextEntry == false ? Asset.Media.icHidden.image: Asset.Media.icShown.image, for: .normal)
        
        self.reenterPasswordTF.isSecureTextEntry.toggle()
    }
}

extension SignUpVC {
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
        
        nameStack.addArrangedSubview(nameLabel)
        nameStack.addArrangedSubview(nameTF)
        self.nameStack.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(48)
            make.left.equalTo(self.contentView.snp.left).offset(24)
            make.right.equalTo(self.contentView.snp.right).offset(-24)
        }
        nameTF.snp.makeConstraints { make in
            make.height.equalTo(32)
        }
        self.nameView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.top.equalTo(self.nameStack.snp.bottom)
            make.left.equalTo(self.nameStack.snp.left)
            make.right.equalTo(self.nameStack.snp.right)
        }
        
        surnameStack.addArrangedSubview(surnameLabel)
        surnameStack.addArrangedSubview(surnameTF)
        self.surnameStack.snp.makeConstraints { make in
            make.top.equalTo(self.nameStack.snp.bottom).offset(24)
            make.left.equalTo(self.contentView.snp.left).offset(24)
            make.right.equalTo(self.contentView.snp.right).offset(-24)
        }
        surnameTF.snp.makeConstraints { make in
            make.height.equalTo(32)
        }
        self.surnameView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.top.equalTo(self.surnameStack.snp.bottom)
            make.left.equalTo(self.surnameStack.snp.left)
            make.right.equalTo(self.surnameStack.snp.right)
        }
        
        emailStack.addArrangedSubview(emailLabel)
        emailStack.addArrangedSubview(emailTF)
        self.emailStack.snp.makeConstraints { make in
            make.top.equalTo(self.surnameStack.snp.bottom).offset(24)
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
        self.passwordRightButton.snp.makeConstraints { make in
            make.width.height.equalTo(24)
        }
        self.passwordView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.top.equalTo(self.passwordStack.snp.bottom)
            make.left.equalTo(self.passwordStack.snp.left)
            make.right.equalTo(self.passwordStack.snp.right)
        }
        
        rePasswordStack.addArrangedSubview(rePasswordLabel)
        rePasswordStack.addArrangedSubview(reenterPasswordTF)
        self.rePasswordStack.snp.makeConstraints { make in
            make.top.equalTo(self.passwordStack.snp.bottom).offset(24)
            make.left.equalTo(self.contentView.snp.left).offset(24)
            make.right.equalTo(self.contentView.snp.right).offset(-24)
        }
        reenterPasswordTF.snp.makeConstraints { make in
            make.height.equalTo(32)
        }
        self.rePasswordRightButton.snp.makeConstraints { make in
            make.width.height.equalTo(24)
        }
        self.rePasswordView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.top.equalTo(self.rePasswordStack.snp.bottom)
            make.left.equalTo(self.rePasswordStack.snp.left)
            make.right.equalTo(self.rePasswordStack.snp.right)
        }
        
        signUpButton.snp.makeConstraints { make in
            make.height.equalTo(48)
            make.top.equalTo(self.rePasswordStack.snp.bottom).offset(46)
            make.left.equalTo(self.contentView.snp.left).offset(32)
            make.right.equalTo(self.contentView.snp.right).offset(-32)
        }
        
        self.signInLabel.snp.makeConstraints { make in
            make.centerX.equalTo(self.signUpButton.snp.centerX)
            make.top.equalTo(self.signUpButton.snp.bottom).offset(16)
            make.bottom.lessThanOrEqualTo(self.contentView.snp.bottom).offset(-32)
        }
    }
}

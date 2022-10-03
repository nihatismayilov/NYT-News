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
    
    lazy var nameImage: UIImageView = {
        let img = UIImageView()
        self.contentView.addSubview(img)
        img.tintColor = Asset.Colors.redWithDark.color
        img.image = Asset.Media.icName.image
        
        return img
    }()
    
    lazy var nameTF: UITextField = {
        let tf = UITextField()
        self.contentView.addSubview(tf)
        tf.textColor = Asset.Colors.textColor.color
        tf.placeholder = "Name"
        tf.delegate = self
        tf.autocorrectionType = .no
        tf.autocapitalizationType = .none
        
        return tf
    }()
    
    lazy var nameView: UIView = {
        let view = UIView()
        self.contentView.addSubview(view)
        view.backgroundColor = .lightGray
        
        return view
    }()
    
    lazy var surnameImage: UIImageView = {
        let img = UIImageView()
        self.contentView.addSubview(img)
        img.tintColor = Asset.Colors.redWithDark.color
        img.image = Asset.Media.icName.image
        
        return img
    }()
    
    lazy var surnameTF: UITextField = {
        let tf = UITextField()
        self.contentView.addSubview(tf)
        tf.textColor = Asset.Colors.textColor.color
        tf.placeholder = "Surname"
        tf.delegate = self
        tf.autocorrectionType = .no
        tf.autocapitalizationType = .none
        
        return tf
    }()
    
    lazy var surnameView: UIView = {
        let view = UIView()
        self.contentView.addSubview(view)
        view.backgroundColor = .lightGray
        
        return view
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
        tf.placeholderRect(forBounds: CGRect(x: 0, y: 0, width: 10, height: 10))
        tf.placeholder = "Mail"
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
    
    lazy var passwordView: UIView = {
        let view = UIView()
        self.contentView.addSubview(view)
        view.backgroundColor = .lightGray
        
        return view
    }()
    
    lazy var reenterPasswordImage: UIImageView = {
        let img = UIImageView()
        self.contentView.addSubview(img)
        img.tintColor = Asset.Colors.redWithDark.color
        img.image = Asset.Media.icPassword.image
        
        return img
    }()
    
    lazy var reenterPasswordTF: UITextField = {
        let tf = UITextField()
        self.contentView.addSubview(tf)
        tf.textColor = Asset.Colors.textColor.color
        tf.isSecureTextEntry = true
        tf.autocapitalizationType = .none
        tf.placeholder = "Re-enter password"
        tf.delegate = self
        tf.autocorrectionType = .no
        tf.autocapitalizationType = .none
        
        return tf
    }()
    
    lazy var reenterPasswordView: UIView = {
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
        
        btn.layer.shadowOffset = CGSize(width: 0, height: 0)
        btn.layer.shadowRadius = 4
        btn.layer.shadowColor = UIColor.systemRed.cgColor
        btn.layer.shadowOpacity = 0.7
        
        return btn
    }()
    
    lazy var signInLabel: UILabel = {
        let lbl = UILabel()
        self.contentView.addSubview(lbl)
        lbl.font = UIFont(font: FontFamily.NunitoSans.semiBold, size: 12)
        lbl.textColor = .lightGray
        
        var firstAttributedString = NSMutableAttributedString()
        firstAttributedString = NSMutableAttributedString(string: "Already a member? Sign in")
        firstAttributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: Asset.Colors.accentColor.color as Any, range: NSRange(location: 18, length: 7))
        
        var secondAS = NSMutableAttributedString()
        secondAS = firstAttributedString
        secondAS.addAttribute(NSAttributedString.Key.font, value: UIFont(font: FontFamily.NunitoSans.bold, size: 12)  as Any, range: NSRange(location: 18, length: 7))
        
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
        self.passwordRightView()
        self.rePasswordRightView()
        
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
        let conditionsRange = (text as NSString).range(of: "Sign in")
        let cancellationRange = (text as NSString).range(of: "Already a member? ")
        
        if gesture.didTapAttributedTextInLabel(label: self.signInLabel, inRange: conditionsRange) {
            self.dismiss(animated: true)
        } else if gesture.didTapAttributedTextInLabel(label: self.signInLabel, inRange: cancellationRange) {
            // empty
        }
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
        passwordRightButton.tintColor = Asset.Colors.redWithDark.color
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
        rePasswordRightButton.tintColor = Asset.Colors.redWithDark.color
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

extension SignUpVC: UITextFieldDelegate {
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == self.nameTF {
            self.nameView.backgroundColor = Asset.Colors.accentColor.color
        } else if textField == self.surnameTF {
            self.surnameView.backgroundColor = Asset.Colors.accentColor.color
        } else if textField == self.emailTF {
            self.emailView.backgroundColor = Asset.Colors.accentColor.color
        } else if textField == self.passwordTF {
            self.passwordView.backgroundColor = Asset.Colors.accentColor.color
        } else if textField == self.reenterPasswordTF {
            self.reenterPasswordView.backgroundColor = Asset.Colors.accentColor.color
        }
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == self.nameTF {
            self.nameView.backgroundColor = .lightGray
        } else if textField == self.surnameTF {
            self.surnameView.backgroundColor = .lightGray
        } else if textField == self.emailTF {
            self.emailView.backgroundColor = .lightGray
        } else if textField == self.passwordTF {
            self.passwordView.backgroundColor = .lightGray
        } else if textField == self.reenterPasswordTF {
            self.reenterPasswordView.backgroundColor = .lightGray
        }
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
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
//            make.height.equalTo(self.scrollView.snp.height)
        }
        
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.contentView.safeAreaLayoutGuide.snp.top).offset(56)
            make.left.equalTo(self.contentView.snp.left).offset(16)
        }
        
        nameImage.snp.makeConstraints { make in
            make.width.height.equalTo(24)
            make.top.equalTo(self.titleLabel.snp.bottom).offset(48)
            make.left.equalTo(self.contentView.snp.left).offset(24)
        }
        nameTF.snp.makeConstraints { make in
            make.height.equalTo(32)
            make.centerY.equalTo(self.nameImage.snp.centerY)
            make.left.equalTo(self.nameImage.snp.right).offset(8)
            make.right.equalTo(self.contentView.snp.right).offset(-24)
        }
        self.nameView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.top.equalTo(self.nameTF.snp.bottom)
            make.left.equalTo(self.nameTF.snp.left)
            make.right.equalTo(self.nameTF.snp.right)
        }
        
        surnameImage.snp.makeConstraints { make in
            make.width.height.equalTo(24)
            make.top.equalTo(self.nameView.snp.bottom).offset(48)
            make.left.equalTo(self.contentView.snp.left).offset(24)
        }
        surnameTF.snp.makeConstraints { make in
            make.height.equalTo(32)
            make.centerY.equalTo(self.surnameImage.snp.centerY)
            make.left.equalTo(self.surnameImage.snp.right).offset(8)
            make.right.equalTo(self.contentView.snp.right).offset(-24)
        }
        self.surnameView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.top.equalTo(self.surnameTF.snp.bottom)
            make.left.equalTo(self.surnameTF.snp.left)
            make.right.equalTo(self.surnameTF.snp.right)
        }
        
        emailImage.snp.makeConstraints { make in
            make.width.height.equalTo(20)
            make.top.equalTo(self.surnameView.snp.bottom).offset(48)
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
        
        reenterPasswordImage.snp.makeConstraints { make in
            make.width.height.equalTo(24)
            make.top.equalTo(self.passwordView.snp.bottom).offset(48)
            make.left.equalTo(self.contentView.snp.left).offset(24)
        }
        reenterPasswordTF.snp.makeConstraints { make in
            make.height.equalTo(32)
            make.centerY.equalTo(self.reenterPasswordImage.snp.centerY)
            make.left.equalTo(self.reenterPasswordImage.snp.right).offset(8)
            make.right.equalTo(self.contentView.snp.right).offset(-24)
        }
        self.reenterPasswordView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.top.equalTo(self.reenterPasswordTF.snp.bottom)
            make.left.equalTo(self.reenterPasswordTF.snp.left)
            make.right.equalTo(self.reenterPasswordTF.snp.right)
        }
        
        signUpButton.snp.makeConstraints { make in
            make.height.equalTo(48)
            make.top.equalTo(self.reenterPasswordView.snp.bottom).offset(46)
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

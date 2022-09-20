//
//  SignUpVC.swift
//  presentation
//
//  Created by Nihad Ismayilov on 20.09.22.
//

import Foundation
import UIKit
import SnapKit

public class SignUpVC: BaseVC<SignUpVM> {
    
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
    
    lazy var subtitleLabel: UILabel = {
        let lbl = UILabel()
        self.contentView.addSubview(lbl)
        lbl.textColor = .lightGray
        lbl.font = UIFont(font: FontFamily.NunitoSans.semiBold, size: 16)
        lbl.text = "Create your new account"
        
        return lbl
    }()
    
    lazy var fullNameStack: UIStackView = {
        let stack = UIStackView()
        self.contentView.addSubview(stack)
        stack.axis = .vertical
        stack.spacing = 8
        stack.distribution = .equalSpacing
        
        return stack
    }()
    
    lazy var fullNameLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Full Name"
        lbl.textColor = Asset.Colors.accentColor.color
        lbl.font = UIFont(font: FontFamily.NunitoSans.bold, size: 16)
        
        return lbl
    }()
    
    lazy var fullNameTF: UITextField = {
        let tf = UITextField()
        tf.textColor = Asset.Colors.textColor.color
        
        return tf
    }()
    
    lazy var fullNameView: UIView = {
        let view = UIView()
        self.contentView.addSubview(view)
        view.backgroundColor = Asset.Colors.textColor.color
        
        return view
    }()
    
    lazy var emailStack: UIStackView = {
        let stack = UIStackView()
        self.contentView.addSubview(stack)
        stack.axis = .vertical
        stack.spacing = 8
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
        
        return tf
    }()
    
    lazy var emailView: UIView = {
        let view = UIView()
        self.contentView.addSubview(view)
        view.backgroundColor = Asset.Colors.textColor.color
        
        return view
    }()
    
    lazy var passwordStack: UIStackView = {
        let stack = UIStackView()
        self.contentView.addSubview(stack)
        stack.axis = .vertical
        stack.spacing = 8
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
        
        return tf
    }()
    
    lazy var passwordView: UIView = {
        let view = UIView()
        self.contentView.addSubview(view)
        view.backgroundColor = Asset.Colors.textColor.color
        
        return view
    }()
    
    lazy var rePasswordStack: UIStackView = {
        let stack = UIStackView()
        self.contentView.addSubview(stack)
        stack.axis = .vertical
        stack.spacing = 8
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
    
    lazy var rePasswordTF: UITextField = {
        let tf = UITextField()
        tf.textColor = Asset.Colors.textColor.color
        
        return tf
    }()
    
    lazy var rePasswordView: UIView = {
        let view = UIView()
        self.contentView.addSubview(view)
        view.backgroundColor = Asset.Colors.textColor.color
        
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
        
        return btn
    }()
    
    lazy var agreeLabel: UILabel = {
        let lbl = UILabel()
        self.contentView.addSubview(lbl)
        lbl.font = UIFont(font: FontFamily.NunitoSans.semiBold, size: 12)
        lbl.textColor = .lightGray
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
        
        var firstColored = NSMutableAttributedString()
        firstColored = NSMutableAttributedString(string: "By continuing, you agree to our Terms of\nServices and Privacy Policy")
        firstColored.addAttribute(NSAttributedString.Key.foregroundColor, value: Asset.Colors.accentColor.color as Any, range: NSRange(location: 32, length: 18))
        
        var firstFont = NSMutableAttributedString()
        firstFont = firstColored
        firstFont.addAttribute(NSAttributedString.Key.font, value: UIFont(font: FontFamily.NunitoSans.bold, size: 12)  as Any, range: NSRange(location: 32, length: 18))
        
        var secondColored = NSMutableAttributedString()
        secondColored = firstFont
        secondColored.addAttribute(NSAttributedString.Key.foregroundColor, value: Asset.Colors.accentColor.color as Any, range: NSRange(location: 54, length: 14))
        
        var secondFont = NSMutableAttributedString()
        secondFont = secondColored
        secondFont.addAttribute(NSAttributedString.Key.font, value: UIFont(font: FontFamily.NunitoSans.bold, size: 12)  as Any, range: NSRange(location: 54, length: 14))
        
        lbl.isUserInteractionEnabled = true
        
        lbl.attributedText = secondFont
        
        return lbl
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
//        self.rightView()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    // MARK: - Functions
    @objc func onSignUpTapped(_ gesture: UITapGestureRecognizer) {
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
}

extension SignUpVC {
    func setupUI() {
        self.scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        self.contentView.snp.makeConstraints { make in
            make.edges.equalTo(self.scrollView.snp.edges)
            make.width.equalTo(self.scrollView.snp.width)
            make.height.equalTo(900)
        }
        
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.contentView.safeAreaLayoutGuide.snp.top).offset(56)
            make.left.equalTo(self.contentView.snp.left).offset(16)
        }
        
        self.subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(8)
            make.left.equalTo(self.titleLabel.snp.left)
        }
        
        fullNameStack.addArrangedSubview(fullNameLabel)
        fullNameStack.addArrangedSubview(fullNameTF)
        self.fullNameStack.snp.makeConstraints { make in
            make.top.equalTo(self.subtitleLabel.snp.bottom).offset(48)
            make.left.equalTo(self.contentView.snp.left).offset(24)
            make.right.equalTo(self.contentView.snp.right).offset(-24)
        }
        self.fullNameView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.top.equalTo(self.fullNameStack.snp.bottom)
            make.left.equalTo(self.fullNameStack.snp.left)
            make.right.equalTo(self.fullNameStack.snp.right)
        }
        
        emailStack.addArrangedSubview(emailLabel)
        emailStack.addArrangedSubview(emailTF)
        self.emailStack.snp.makeConstraints { make in
            make.top.equalTo(self.fullNameStack.snp.bottom).offset(24)
            make.left.equalTo(self.contentView.snp.left).offset(24)
            make.right.equalTo(self.contentView.snp.right).offset(-24)
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
        self.passwordView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.top.equalTo(self.passwordStack.snp.bottom)
            make.left.equalTo(self.passwordStack.snp.left)
            make.right.equalTo(self.passwordStack.snp.right)
        }
        
        rePasswordStack.addArrangedSubview(rePasswordLabel)
        rePasswordStack.addArrangedSubview(rePasswordTF)
        self.rePasswordStack.snp.makeConstraints { make in
            make.top.equalTo(self.passwordStack.snp.bottom).offset(24)
            make.left.equalTo(self.contentView.snp.left).offset(24)
            make.right.equalTo(self.contentView.snp.right).offset(-24)
        }
        self.rePasswordView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.top.equalTo(self.rePasswordStack.snp.bottom)
            make.left.equalTo(self.rePasswordStack.snp.left)
            make.right.equalTo(self.rePasswordStack.snp.right)
        }
        
        signUpButton.snp.makeConstraints { make in
            make.height.equalTo(48)
            make.top.equalTo(self.rePasswordStack.snp.bottom).offset(80)
            make.left.equalTo(self.contentView.snp.left).offset(32)
            make.right.equalTo(self.contentView.snp.right).offset(-32)
        }
        
        agreeLabel.snp.makeConstraints { make in
            make.left.equalTo(self.signUpButton.snp.left).offset(4)
            make.right.equalTo(self.signUpButton.snp.right).offset(-4)
            make.bottom.equalTo(self.signUpButton.snp.top).offset(-8)
        }
        
        self.signInLabel.snp.makeConstraints { make in
            make.centerX.equalTo(self.signUpButton.snp.centerX)
            make.top.equalTo(self.signUpButton.snp.bottom).offset(16)
            make.bottom.lessThanOrEqualTo(self.contentView.snp.bottom).offset(-32)
        }
    }
}

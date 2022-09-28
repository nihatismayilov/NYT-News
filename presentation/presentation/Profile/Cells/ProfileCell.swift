//
//  ProfileCell.swift
//  presentation
//
//  Created by Nihad Ismayilov on 18.09.22.
//

import UIKit

class ProfileCell: UITableViewCell {
    // MARK: - Variables
    static let identifier = "profileCell"
    
    var switchCompletion: (() -> Void)?
    
    // MARK: - UI Components
    lazy var backView: UIView = {
        let view = UIView()
        self.contentView.addSubview(view)
        view.backgroundColor = Asset.Colors.backgroundColor.color
        
        return view
    }()
    
    lazy var iconImage: UIImageView = {
        let img = UIImageView()
        self.backView.addSubview(img)
        img.tintColor = Asset.Colors.redWithDark.color
        img.image = Asset.Media.profileLogoutIcon.image
        
        return img
    }()
    
    lazy var stackView: UIStackView = {
        let view = UIStackView()
        self.backView.addSubview(view)
        
        view.alignment = .fill
        view.distribution = .fillProportionally
        view.spacing = 2
        view.axis = .vertical
        
        return view
    }()
    
    lazy var menuTitle: UILabel = {
        let lbl = UILabel()
        self.stackView.addArrangedSubview(lbl)
        lbl.textColor = Asset.Colors.textColor.color
        lbl.font = UIFont(font: FontFamily.NunitoSans.extraBold, size: 16)
        
        return lbl
    }()
    
    lazy var menuDescription: UILabel = {
        let lbl = UILabel()
        self.stackView.addArrangedSubview(lbl)
        lbl.textColor = Asset.Colors.textColor.color
        lbl.font = UIFont(font: FontFamily.NunitoSans.regular, size: 10)
        
        return lbl
    }()
    
    lazy var arrowImage: UIImageView = {
        let img = UIImageView()
        self.backView.addSubview(img)
        img.tintColor = Asset.Colors.redWithDark.color
        img.image = Asset.Media.profileArrow.image
        
        return img
    }()
    
    lazy var switchButton: UISwitch = {
        let btn = UISwitch()
        self.backView.addSubview(btn)
        btn.isHidden = true
        btn.onTintColor = Asset.Colors.accentColor.color
        btn.addTarget(self, action: #selector(onSwitch), for: .allEvents)
        
        return btn
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
       
//        self.contentView.snp.makeConstraints { make in
//            make.left.equalToSuperview()
//            make.right.equalToSuperview()
//            make.height.equalTo(48)
//        }
//
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCellWith(profile: ProfileMenu) {
        self.iconImage.image = profile.icon
        self.menuTitle.text = profile.title
        self.menuDescription.text = profile.description
    }
    
    @objc func onSwitch() {
        switchCompletion?()
    }
    
    private func setupUI() {
        self.backView.snp.makeConstraints { make in
            make.edges.equalTo(self.contentView.snp.edges)
        }
        
        self.iconImage.snp.makeConstraints { make in
            make.width.height.equalTo(24)
            make.left.equalTo(self.backView.snp.left).offset(24)
            make.centerY.equalTo(self.backView.snp.centerY)
        }
        
        self.stackView.snp.makeConstraints { make in
            make.left.equalTo(self.iconImage.snp.right).offset(16)
            make.centerY.equalTo(self.backView.snp.centerY)
        }
        
        self.arrowImage.snp.makeConstraints { make in
            make.width.height.equalTo(16)
            make.right.equalTo(self.backView.snp.right).offset(-24)
            make.centerY.equalTo(self.backView.snp.centerY)
        }
        self.switchButton.snp.makeConstraints { make in
            make.right.equalTo(self.backView.snp.right).offset(-24)
            make.centerY.equalTo(self.backView.snp.centerY)
        }
    }
}

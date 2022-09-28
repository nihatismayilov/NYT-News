//
//  InfoCell.swift
//  presentation
//
//  Created by Nihad Ismayilov on 25.09.22.
//

import Foundation
import UIKit
import SnapKit

class InfoCell: UITableViewCell {
    
    // MARK: - Variables
    static let identifier = "infoCell"
    
    // MARK: - UI Components
    
    lazy var backView: UIView = {
        let view = UIView()
        self.contentView.addSubview(view)
        view.backgroundColor = Asset.Colors.backgroundColor.color
        
        return view
    }()
    
    lazy var firstLabelsView: UIView = {
        let view = UIView()
        self.backView.addSubview(view)
        view.backgroundColor = Asset.Colors.accentColor.color
        view.layer.cornerRadius = 12
        
        return view
    }()
    
    lazy var firstLabels: UILabel = {
        let lbl = UILabel()
        self.firstLabelsView.addSubview(lbl)
        lbl.textColor = .white
        lbl.font = UIFont(font: FontFamily.NunitoSans.bold, size: 24)
        lbl.textAlignment = .center
        lbl.text = "NI"
        
        return lbl
    }()
    
    lazy var infoStack: UIStackView = {
        let stack = UIStackView()
        self.backView.addSubview(stack)
        stack.axis = .vertical
        stack.spacing = 0
        stack.distribution = .equalSpacing
        
        return stack
    }()
    
    lazy var nameLabel: UILabel = {
        let lbl = UILabel()
        
        lbl.textColor = Asset.Colors.textColor.color
        lbl.font = UIFont(font: FontFamily.NunitoSans.bold, size: 18)
        lbl.text = "Nihat Ismayilov"
        
        return lbl
    }()
    
    lazy var mailLabel: UILabel = {
        let lbl = UILabel()
        
        lbl.textColor = Asset.Colors.textColor.color
        lbl.font = UIFont(font: FontFamily.NunitoSans.bold, size: 14)
        lbl.text = "nihat@gmail.com"
        
        return lbl
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
       
        self.contentView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.greaterThanOrEqualTo(64)
        }
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCellWith(title: String, name: String, mail: String) {
        self.firstLabels.text = title
        self.nameLabel.text = name
        self.mailLabel.text = mail
    }
    
    private func setupUI() {
        backView.snp.makeConstraints { make in
            make.top.equalTo(self.contentView.snp.top)
            make.left.equalTo(self.contentView.snp.left)
            make.right.equalTo(self.contentView.snp.right)
            make.bottom.equalTo(self.contentView.snp.bottom)
        }
        
        self.firstLabelsView.snp.makeConstraints { make in
            make.width.height.equalTo(48)
            make.left.equalTo(self.backView.snp.left).offset(24)
            make.top.equalTo(self.backView.snp.top)
        }
        
        self.firstLabels.snp.makeConstraints { make in
            make.top.equalTo(self.firstLabelsView.snp.top)
            make.left.equalTo(self.firstLabelsView.snp.left)
            make.right.equalTo(self.firstLabelsView.snp.right)
            make.bottom.equalTo(self.firstLabelsView.snp.bottom)
        }
        
        self.infoStack.addArrangedSubview(nameLabel)
        self.infoStack.addArrangedSubview(mailLabel)
        self.infoStack.snp.makeConstraints { make in
            make.top.equalTo(self.firstLabelsView.snp.top)
            make.left.equalTo(self.firstLabelsView.snp.right).offset(8)
            make.right.equalTo(self.backView.snp.right)
            make.bottom.equalTo(self.firstLabelsView.snp.bottom)
        }
    }
}

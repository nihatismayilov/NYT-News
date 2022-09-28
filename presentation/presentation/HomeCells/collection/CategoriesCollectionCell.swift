//
//  CategoriesCollectionCell.swift
//  presentation
//
//  Created by Nihad Ismayilov on 13.09.22.
//

import Foundation
import UIKit
import SnapKit

class CategoriesCollectionCell: UICollectionViewCell {
    
    static let identifier = "CategoriesCollectionCell"
    var completion: (() -> Void)?
    
    lazy var categoryView: UIView = {
        let view = UIView()
        self.contentView.addSubview(view)

        return view
    }()
    
    lazy var categoryTitle: UILabel = {
        let lbl = UILabel()
        self.contentView.addSubview(lbl)
        lbl.textColor = Asset.Colors.textColor.color
        lbl.font = UIFont(font: FontFamily.NunitoSans.bold, size: 16)
        lbl.textAlignment = .center
        lbl.text = "briefing"
        
        return lbl
    }()
    
    lazy var underlineView: UIView = {
        let view = UIView()
        self.contentView.addSubview(view)
        view.backgroundColor = .clear
        
        return view
    }()
    

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.clipsToBounds = false
        contentView.layer.cornerRadius = 12
//        contentView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        contentView.snp.makeConstraints { make in
            make.left.equalTo(self.snp.left)
            make.right.equalTo(self.snp.right)
            make.height.equalTo(48)
        }
        
        self.setupUI()
    }
    
    func setupCellWith(title: String, color: UIColor) {
        self.categoryTitle.text = title
//        self.isSelectedView.backgroundColor = color
        
    }
    
    @objc func onSelect() {
//        isSelectedView.backgroundColor = .clear
        completion?()
    }
    
    private func setupUI() {
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onSelect))
//        self.categoryView.addGestureRecognizer(tapGesture)
        self.categoryView.clipsToBounds = true
        self.categoryView.layer.cornerRadius = 12
        self.categoryView.snp.makeConstraints { make in
            make.left.equalTo(self.contentView.snp.left)
            make.right.equalTo(self.contentView.snp.right)
            make.top.equalTo(self.contentView.snp.top)
            make.bottom.equalTo(self.contentView.snp.bottom)
        }
        
        self.categoryTitle.snp.makeConstraints { make in
            make.left.equalTo(self.categoryView.snp.left).offset(4)
            make.right.equalTo(self.categoryView.snp.right).offset(-4)
            make.top.equalTo(self.categoryView.snp.top).offset(4)
            make.bottom.equalTo(self.categoryView.snp.bottom).offset(-4)
        }
        
//        self.underlineView.backgroundColor = .red
        self.underlineView.layer.cornerRadius = 2
        self.underlineView.snp.makeConstraints { make in
            make.bottom.equalTo(self.contentView.snp.bottom)
            make.left.equalTo(self.categoryTitle.snp.left)
            make.right.equalTo(self.categoryTitle.snp.right)
            make.height.equalTo(4)
        }
    }
}

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
        self.categoryView.addSubview(lbl)
        lbl.textColor = Asset.Colors.textColor.color
        lbl.font = UIFont(font: FontFamily.NunitoSans.bold, size: 16)
        lbl.textAlignment = .center
        lbl.text = "briefing"
        
        return lbl
    }()
    
    lazy var isSelectedView: UIView = {
        let view = UIView()
        self.contentView.addSubview(view)
        view.backgroundColor = Asset.Colors.backgroundColor.color
        
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
//        contentView.clipsToBounds = true
//        contentView.layer.cornerRadius = 12
        contentView.snp.makeConstraints { make in
            make.left.equalTo(self.snp.left)
            make.right.equalTo(self.snp.right)
            make.height.equalTo(48)
//            make.top.equalTo(self.snp.top)
//            make.bottom.equalTo(self.snp.bottom)
//            make.width.equalTo(80)
//            make.width.lessThanOrEqualTo(112)
        }
        
        self.setupUI()
    }
    
    func setupCellWith(title: String, color: UIColor) {
        self.categoryTitle.text = title
        self.isSelectedView.backgroundColor = color
        
    }
    
    @objc func onSelect() {
        isSelectedView.backgroundColor = Asset.Colors.backgroundColor.color
        completion?()
    }
    
    private func setupUI() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onSelect))
        self.categoryView.addGestureRecognizer(tapGesture)
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
        
        self.isSelectedView.layer.cornerRadius = 2
        self.isSelectedView.snp.makeConstraints { make in
            make.bottom.equalTo(self.contentView.snp.bottom)
            make.left.equalTo(self.categoryTitle.snp.left)
            make.right.equalTo(self.categoryTitle.snp.right)
            make.height.equalTo(4)
        }
    }
}

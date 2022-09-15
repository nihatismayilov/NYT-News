//
//  CategoriesCell.swift
//  presentation
//
//  Created by Nihad Ismayilov on 13.09.22.
//

import Foundation
import UIKit
import SnapKit
import domain

class CategoriesCell: UITableViewCell {
    // MARK: - Variables
    static let identifier = "categoriesCell"

    var selectCategoryCompletion: ((_ index: Int) -> Void)?

    // MARK: - UI Components

    lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: 112, height: 40)
        let view = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        view.bounces = false
        view.showsHorizontalScrollIndicator = false
        self.contentView.addSubview(view)

        view.dataSource = self
        view.delegate = self
        view.register(CategoriesCollectionCell.self, forCellWithReuseIdentifier: CategoriesCollectionCell.identifier)

        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview()
            make.height.equalTo(64)
        }
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        self.collectionView.snp.makeConstraints { make in
            make.left.equalTo(self.contentView.snp.left)
            make.top.equalTo(self.contentView.snp.top)
            make.right.equalTo(self.contentView.snp.right)
            make.bottom.equalTo(self.contentView.snp.bottom)
            make.height.equalTo(40)
        }
    }
}

extension CategoriesCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CategoriesMenu.items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoriesCollectionCell.identifier, for: indexPath) as! CategoriesCollectionCell
        
        cell.completion = {
            if CategoriesMenu.items[indexPath.row].isSelected == false {
                cell.isSelectedView.backgroundColor = Asset.Colors.redColor.color
                CategoriesMenu.items[indexPath.row].isSelected = true
                self.selectCategoryCompletion?(indexPath.row)
            } else {
                cell.isSelectedView.backgroundColor = Asset.Colors.backgroundColor.color
                CategoriesMenu.items[indexPath.row].isSelected = false
            }
        }
        
        cell.setupCellWith(title: CategoriesMenu.items[indexPath.row].title, color: CategoriesMenu.items[indexPath.row].backColor)
        return cell
    }
}

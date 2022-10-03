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
    
    var categoriesArray =
    [
        Asset.Colors.accentColor.color,
        Asset.Colors.redColor2.color.withAlphaComponent(0.1),
        Asset.Colors.redColor2.color.withAlphaComponent(0.1),
        Asset.Colors.redColor2.color.withAlphaComponent(0.1),
        Asset.Colors.redColor2.color.withAlphaComponent(0.1),
        Asset.Colors.redColor2.color.withAlphaComponent(0.1),
        Asset.Colors.redColor2.color.withAlphaComponent(0.1),
        Asset.Colors.redColor2.color.withAlphaComponent(0.1)
    ]

    var selectCategoryCompletion: ((_ index: Int) -> Void)?
    
    var show: Bool = false {
        willSet {
            if newValue {
//                self.selectedHeight?.isActive = false
//                self.selectedHeight = self.isSelectedView.heightAnchor.constraint(equalToConstant: 2)
//                self.selectedHeight?.isActive = true
//                self.selectedHeight?.isActive = true
//                self.selectedHeight?.isActive = true
            }
        }
    }

    // MARK: - UI Components

    lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: 112, height: 64)
        let view = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        view.bounces = false
        view.showsHorizontalScrollIndicator = false
        self.contentView.addSubview(view)
        
        view.dataSource = self
        view.delegate = self
        view.register(CategoriesCollectionCell.self, forCellWithReuseIdentifier: CategoriesCollectionCell.identifier)
        
        return view
    }()
    
//    lazy var isSelectedView: UIView = {
//        let view = UIView()
//        self.contentView.addSubview(view)
//        view.backgroundColor = Asset.Colors.redColor.color
//
//        return view
//    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.snp.makeConstraints { make in
            make.left.equalToSuperview()
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
            make.height.equalTo(56)
        }
    }
}

extension CategoriesCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CategoriesMenu.items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoriesCollectionCell.identifier, for: indexPath) as! CategoriesCollectionCell
        
        cell.categoryView.backgroundColor = categoriesArray[indexPath.row]
//        cell.backgroundColor = .systemBlue
//        cell.completion = {
//            cell.categoryView.backgroundColor = Asset.Colors.dateColor.color
//        }
        
        cell.setupCellWith(title: CategoriesMenu.items[indexPath.row].title, color: CategoriesMenu.items[indexPath.row].backColor)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 112, height: 56)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("HEREHER")
        selectCategoryCompletion?(indexPath.row)
        let myGroup = DispatchGroup()
        for i in 0...categoriesArray.count - 1 {
            myGroup.enter()
            if i == indexPath.row {
                categoriesArray[i] = Asset.Colors.accentColor.color
            } else {
                categoriesArray[i] = Asset.Colors.redColor2.color.withAlphaComponent(0.1)
            }
            myGroup.leave()
        }
        
        myGroup.notify(queue: .main) {
            self.collectionView.reloadData()
        }
//        switch categoriesArray.count - 1 {
//        case indexPath.row:
//            categoriesArray[indexPath.row] = Asset.Colors.accentColor.color
//            collectionView.reloadData()
//        default:
//            categoriesArray[indexPath.row] = Asset.Colors.redColor2.color.withAlphaComponent(0.1)
//
//        }
//        if categoriesArray[indexPath.row] == Asset.Colors.accentColor.color {
//            Asset.Colors.redColor2.color.withAlphaComponent(0.1)
//            collectionView.reloadData()
//        } else {
//            categoriesArray[indexPath.row] = Asset.Colors.accentColor.color
//            collectionView.reloadData()
//        }
    }
}

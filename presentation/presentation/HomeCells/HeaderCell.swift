//
//  HeaderCell.swift
//  presentation
//
//  Created by Nihad Ismayilov on 10.09.22.
//

import UIKit
import SnapKit
import domain

class HeaderCell: UITableViewCell {
    // MARK: - Variables
    static let identifier = "headerCell"
    var breakingNews = [PopularNews.PopularResults]()
    
    // MARK: - UI Components
    
    private lazy var titleLabel: UILabel = {
        let lbl = UILabel()
        self.contentView.addSubview(lbl)
        lbl.textColor = Asset.Colors.textColor.color
        
        lbl.font = UIFont(font: FontFamily.NunitoSans.extraBold, size: 32)
        lbl.text = "Breaking News"
        
        return lbl
    }()
    
    lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: 320, height: 400)
        let view = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        view.bounces = false
        view.showsHorizontalScrollIndicator = false
        self.contentView.addSubview(view)
        
        view.dataSource = self
        view.delegate = self
        view.register(BreakingNewsCollectionCell.self, forCellWithReuseIdentifier: BreakingNewsCollectionCell.identifier)
        
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(400)
        }
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.contentView.snp.top).offset(16)
            make.left.equalTo(self.contentView.snp.left).offset(24)
        }
        
        self.collectionView.snp.makeConstraints { make in
            make.left.equalTo(self.contentView.snp.left)
            make.top.equalTo(self.titleLabel.snp.bottom).offset(4)
            make.right.equalTo(self.contentView.snp.right)
            make.height.equalTo(400)
        }
    }
}

extension HeaderCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.breakingNews.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BreakingNewsCollectionCell.identifier, for: indexPath) as! BreakingNewsCollectionCell
        cell.setupCellWith(breakingNews: self.breakingNews[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 280, height: 400)
    }
}

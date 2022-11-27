//
//  SavedCell.swift
//  presentation
//
//  Created by Nihad Ismayilov on 23.09.22.
//

import UIKit
import SnapKit
import Kingfisher

class SavedCell: UITableViewCell {
    
    // MARK: - Variables
    static var identifier = "savedCell"
    
    // MARK: - UI Components
    
    lazy var backView: UIView = {
        let view = UIView()
        self.contentView.addSubview(view)
        view.backgroundColor = Asset.Colors.backgroundColor.color
        
        return view
    }()
    
    lazy var thumbView: UIView = {
        let view = UIView()
        self.backView.addSubview(view)
        
        return view
    }()
    
    lazy var thumbImage: UIImageView = {
        let img = UIImageView()
        self.thumbView.addSubview(img)
        img.contentMode = .scaleAspectFill
        img.image = Asset.Media.girlCampingBesideACar1280Ã800.image
        
        return img
    }()
    
    lazy var titleLabel: UILabel = {
        let lbl = UILabel()
        self.backView.addSubview(lbl)
        lbl.textColor = Asset.Colors.textColor.color
        lbl.font = UIFont(font: FontFamily.NunitoSans.bold, size: 16)
        lbl.numberOfLines = 3
        lbl.text = "N/A"
        
        return lbl
    }()
    
    lazy var categoryView: UIView = {
        let view = UIView()
        self.backView.addSubview(view)
        view.backgroundColor = Asset.Colors.redColor2.color.withAlphaComponent(0.2)
        
        return view
    }()
    
    lazy var categoryLbl: UILabel = {
        let lbl = UILabel()
        self.categoryView.addSubview(lbl)
        lbl.textColor = Asset.Colors.categoryColor.color
        lbl.font = UIFont(font: FontFamily.NunitoSans.semiBold, size: 14)
        lbl.numberOfLines = 0
        lbl.text = "N/A"
        
        return lbl
    }()
    
    lazy var dateLbl: UILabel = {
        let lbl = UILabel()
        self.backView.addSubview(lbl)
        lbl.textAlignment = .left
        lbl.textColor = Asset.Colors.dateColor.color
        lbl.font = UIFont(font: FontFamily.NunitoSans.bold, size: 12)
        lbl.numberOfLines = 0
        lbl.text = "N/A"
        
        return lbl
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = Asset.Colors.backgroundColor.color
        contentView.clipsToBounds = false
        contentView.layer.cornerRadius = 12
        
        self.contentView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(128)
        }
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCellWith(news: DetailsModel) {
        var imageUrl: URL?
        if let url = news.image {
            imageUrl = URL.init(string: "\(url)")
        }
        self.thumbImage.kf.setImage(with: imageUrl, placeholder: UIImage()) { result in
            switch result {
            case .success(let imageResult):
                self.thumbImage.image = imageResult.image.withRenderingMode(.alwaysOriginal)
            case .failure(let err):
                print(err)
            }
        }
    if news.title != "" {
        self.titleLabel.text = news.title
    } else {
        self.titleLabel .text = "N/A"
    }
    if news.category != "" {
        self.categoryLbl.text = news.category
    } else {
        self.categoryLbl.text = "n/a"
    }
        self.dateLbl.text = news.pubDate
    }
    
    private func setupUI() {
        self.backView.snp.makeConstraints { make in
            make.edges.equalTo(self.contentView.snp.edges)
        }
        
        thumbView.clipsToBounds = true
        thumbView.layer.cornerRadius = 12
        self.thumbView.snp.makeConstraints { make in
            make.height.equalTo(120)
            make.width.equalTo(120)
            make.centerY.equalTo(self.contentView.snp.centerY)
            make.right.equalTo(self.contentView.snp.right).offset(-24)
        }
        
        thumbImage.layer.cornerRadius = 12
        self.thumbImage.snp.makeConstraints { make in
            make.left.equalTo(self.thumbView.snp.left)
            make.right.equalTo(self.thumbView.snp.right)
            make.top.equalTo(self.thumbView.snp.top)
            make.bottom.equalTo(self.thumbView.snp.bottom)
        }
        
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.thumbImage.snp.top).offset(4)
            make.right.equalTo(self.thumbImage.snp.left).offset(-8)
            make.left.equalTo(self.contentView.snp.left).offset(8)
        }
        
        categoryView.layer.cornerRadius = 4
        self.categoryView.snp.makeConstraints { make in
            make.right.equalTo(self.thumbImage.snp.left).offset(-8)
            make.bottom.equalTo(self.thumbImage.snp.bottom).offset(-4)
        }
        
        self.categoryLbl.snp.makeConstraints { make in
            make.left.equalTo(self.categoryView.snp.left).offset(8)
            make.right.equalTo(self.categoryView.snp.right).offset(-8)
            make.top.equalTo(self.categoryView.snp.top)
            make.bottom.equalTo(self.categoryView.snp.bottom)
        }
        
        self.dateLbl.snp.makeConstraints { make in
            make.left.equalTo(self.contentView.snp.left).offset(8)
            make.right.equalTo(self.categoryView.snp.left).offset(-8)
            make.bottom.equalTo(self.thumbImage.snp.bottom).offset(-4)
        }
    }

}

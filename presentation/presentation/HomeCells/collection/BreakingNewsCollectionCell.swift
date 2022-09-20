//
//  BreakingNewsCell.swift
//  presentation
//
//  Created by Nihad Ismayilov on 10.09.22.
//

import UIKit
import domain
import Kingfisher

class BreakingNewsCollectionCell: UICollectionViewCell {
    
    static let identifier = "BreakingNewsCell"
    
    lazy var thumbImage: UIImageView = {
        let image = UIImageView()
        
        image.contentMode = .scaleAspectFill
        image.image = Asset.Media.girlCampingBesideACar1280Ã800.image
        
        return image
    }()
    
    lazy var blurBackground: UIView = {
        let view = UIView()
        
        view.backgroundColor = .black.withAlphaComponent(0.5)
        
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let lbl = UILabel()
        
        lbl.textColor = .white
        lbl.font = UIFont(font: FontFamily.NunitoSans.bold, size: 20)
        lbl.numberOfLines = 0
        lbl.text = " News from NEw York Times \n News from NEw York Times\n News from NEw York Times"
        
        return lbl
    }()
    
    lazy var descLabel: UILabel = {
        let lbl = UILabel()
        
        lbl.textColor = UIColor.init(white: 0.92, alpha: 1.0)
        lbl.font = UIFont(font: FontFamily.NunitoSans.semiBold, size: 12)
        lbl.numberOfLines = 0
        lbl.text = "API was taken from NYT"
        
        return lbl
    }()
    
    lazy var categorylabel: UILabel = {
        let lbl = UILabel()
        
        lbl.textColor = .white
        lbl.font = UIFont(font: FontFamily.NunitoSans.bold, size: 12)
        lbl.numberOfLines = 0
        lbl.text = "Space"
        
        return lbl
    }()
    
    lazy var publishedDateLabel: UILabel = {
        let lbl = UILabel()
        
        lbl.textColor = UIColor.init(white: 0.92, alpha: 1.0)
        lbl.font = UIFont(font: FontFamily.NunitoSans.semiBold, size: 12)
        lbl.numberOfLines = 0
        lbl.text = "10.09.2022"
        
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 12
        contentView.snp.makeConstraints { make in
            make.left.equalTo(self.snp.left).offset(24)
            make.right.equalTo(self.snp.right).offset(-8)
            make.top.equalTo(self.snp.top)
            make.bottom.equalTo(self.snp.bottom)
            make.height.equalTo(400)
        }
        
        self.setupUI()
    }
    
    func setupCellWith(breakingNews: PopularNews.PopularResults) {
        var mainUrl: URL?
        if let url = breakingNews.media?.first?.mediaMetaData?.last?.url {
            mainUrl = URL.init(string: "\(url)")
        }
        self.thumbImage.kf.setImage(with: mainUrl, placeholder: UIImage()) { result in
            switch result {
            case .success(let imageResult):
                self.thumbImage.image = imageResult.image.withRenderingMode(.alwaysOriginal)
            case .failure(let err):
                print(err)
            }
        }
        
        self.categorylabel.text = breakingNews.category
        self.titleLabel.text = breakingNews.title
        self.descLabel.text = breakingNews.abstract
        self.publishedDateLabel.text = breakingNews.updateDate?.toDateS?.toStringWithTime.getFormattedDateDayMonthYearHour()
    }
    
    private func setupUI() {
        self.contentView.addSubview(thumbImage)
        self.contentView.addSubview(blurBackground)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(descLabel)
        self.contentView.addSubview(categorylabel)
        self.contentView.addSubview(publishedDateLabel)
        
        
        thumbImage.snp.makeConstraints { make in
            make.top.equalTo(self.contentView.snp.top)
            make.left.equalTo(self.contentView.snp.left)
            make.right.equalTo(self.contentView.snp.right)
            make.bottom.equalTo(self.contentView.snp.bottom)
//            make.top.left.right.bottom.equalToSuperview()
        }
        
        blurBackground.snp.makeConstraints { make in
            make.bottom.equalTo(self.thumbImage.snp.bottom)
            make.left.equalTo(self.thumbImage.snp.left)
            make.right.equalTo(self.thumbImage.snp.right)
            make.top.equalTo(self.titleLabel.snp.top).offset(-16)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(self.thumbImage.snp.left).offset(16)
            make.right.equalTo(self.thumbImage.snp.right).offset(-8)
            make.bottom.equalTo(self.descLabel.snp.top).offset(-20)
        }
        
        descLabel.snp.makeConstraints { make in
            make.left.equalTo(self.thumbImage.snp.left).offset(16)
            make.right.equalTo(self.thumbImage.snp.right).offset(-8)
            make.bottom.equalTo(self.categorylabel.snp.top).offset(-16)
        }
        
        categorylabel.snp.makeConstraints { make in
            make.bottom.equalTo(self.publishedDateLabel.snp.top)
            make.left.equalTo(self.thumbImage.snp.left).offset(16)
        }
        
        publishedDateLabel.snp.makeConstraints { make in
            make.left.equalTo(self.thumbImage.snp.left).offset(16)
            make.bottom.equalTo(self.thumbImage.snp.bottom).offset(-16)
        }
    }
}

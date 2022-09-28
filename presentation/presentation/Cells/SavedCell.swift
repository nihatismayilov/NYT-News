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
    
    lazy var image: UIImageView = {
        let img = UIImageView()
        self.backView.addSubview(img)
        img.image = Asset.Media.girlCampingBesideACar1280Ã800.image
        
        return img
    }()
    
    lazy var titleLabel: UILabel = {
        let lbl = UILabel()
        self.backView.addSubview(lbl)
        lbl.textColor = Asset.Colors.textColor.color
        lbl.font = UIFont(font: FontFamily.NunitoSans.bold, size: 20)
        lbl.numberOfLines = 0
        
        lbl.text = "News from NEw York Times \n News from NEw York Times\n News from NEw York Times"
        
        return lbl
    }()
    
    lazy var categoryLabel: UILabel = {
        let lbl = UILabel()
        self.backView.addSubview(lbl)
        lbl.textColor = Asset.Colors.textColor.color
        lbl.font = UIFont(font: FontFamily.NunitoSans.bold, size: 12)
        
        return lbl
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.layer.cornerRadius = 12
        self.contentView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.greaterThanOrEqualTo(264)
        }
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCellWith(img: String, title: String) {
        var imageUrl: URL?
        if let url = img as? String {
            imageUrl = URL.init(string: "\(url)")
        }
        self.image.kf.setImage(with: imageUrl, placeholder: UIImage()) { result in
            switch result {
            case .success(let imageResult):
                self.image.image = imageResult.image.withRenderingMode(.alwaysOriginal)
            case .failure(let err):
                print(err)
            }
        }
        
        self.titleLabel.text = title
    }
    
    private func setupUI() {
        backView.snp.makeConstraints { make in
            make.top.equalTo(self.contentView.snp.top)
            make.left.equalTo(self.contentView.snp.left)
            make.right.equalTo(self.contentView.snp.right)
            make.bottom.equalTo(self.contentView.snp.bottom)
        }
        
        self.image.clipsToBounds = true
        self.image.layer.cornerRadius = 12
        self.image.snp.makeConstraints { make in
            make.top.equalTo(self.backView.snp.top)
            make.left.equalTo(self.backView.snp.left).offset(24)
            make.right.equalTo(self.backView.snp.right).offset(-24)
            make.height.lessThanOrEqualTo(160)
        }
        
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.image.snp.bottom)
            make.left.equalTo(self.image.snp.left)
            make.right.equalTo(self.image.snp.right)
            make.bottom.equalTo(self.backView.snp.bottom)
        }
        
    }

}

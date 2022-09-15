//
//  DetailsVC.swift
//  presentation
//
//  Created by Nihad Ismayilov on 13.09.22.
//

import Foundation
import UIKit
import SnapKit

public class DetailsVC: BaseVC<DetailsViewModel>, UIGestureRecognizerDelegate {
    
    lazy var backView: UIView = {
        let view = UIView()
        self.contentView.addSubview(view)
        view.backgroundColor = Asset.Colors.redColor.color.withAlphaComponent(0.2)
        
//        let gesture = UITapGestureRecognizer(target: self, action: #selector(onBackTapped))
//        view.addGestureRecognizer(gesture)
        
        return view
    }()
    
    lazy var backButton: UIButton = {
        let btn = UIButton()
        self.backView.addSubview(btn)
        btn.setImage(Asset.Media.icBack.image, for: .normal)
//        btn.addTarget(self, action: #selector(onBackTapped), for: .touchUpInside)
        
        return btn
    }()
    
    lazy var shareView: UIView = {
        let view = UIView()
        self.contentView.addSubview(view)
        view.backgroundColor = Asset.Colors.redColor2.color.withAlphaComponent(0.2)
        
        return view
    }()
    
    lazy var shareButton: UIButton = {
        let btn = UIButton()
        self.shareView.addSubview(btn)
        btn.setImage(Asset.Media.icDownload.image, for: .normal)
        
        return btn
    }()
    
    lazy var imageView: UIImageView = {
        let img = UIImageView()
        self.contentView.addSubview(img)
        img.image = Asset.Media.girlCampingBesideACar1280Ã800.image
        img.contentMode = .scaleAspectFill
        
        return img
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        self.view.addSubview(scroll)
        scroll.showsVerticalScrollIndicator = false
        scroll.showsHorizontalScrollIndicator = false
        
        return scroll
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        self.scrollView.addSubview(view)

        return view
    }()
    
    lazy var detailsView: UIView = {
        let view = UIView()
        self.contentView.addSubview(view)
        view.backgroundColor = Asset.Colors.backgroundColor.color
        
        return view
    }()
    
    lazy var writtenByView: UIView = {
       let view = UIView()
        self.detailsView.addSubview(view)
        view.layer.cornerRadius = 12
        view.backgroundColor = Asset.Colors.redColor.color
        
        return view
    }()
    
    lazy var writtenByLabel: UILabel = {
        let lbl = UILabel()
        self.writtenByView.addSubview(lbl)
        lbl.textColor = .white
        lbl.font = UIFont(font: FontFamily.NunitoSans.semiBold, size: 14)
        lbl.text = "David Gelles"
        
        return lbl
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Asset.Colors.backgroundColor.color
        self.setupUI()
        backButton.addTarget(self, action: #selector(onBackTapped), for: .allTouchEvents)
        
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        self.navigationController?.isNavigationBarHidden = true
    }
    
    @objc func onBackTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension DetailsVC {
    func setupUI() {
        self.imageView.snp.makeConstraints { make in
            make.top.equalTo(self.contentView.snp.top)
            make.left.equalTo(self.contentView.snp.left)
            make.right.equalTo(self.contentView.snp.right)
            make.bottom.equalTo(self.contentView.snp.centerY)
        }
        
        self.backView.layer.cornerRadius = 10
        self.backView.snp.makeConstraints { make in
            make.left.equalTo(self.contentView.snp.left).offset(24)
            make.top.equalTo(self.contentView.safeAreaLayoutGuide.snp.top).offset(24)
            make.width.height.equalTo(40)
        }
        
        self.backButton.snp.makeConstraints { make in
            make.center.equalTo(self.backView.snp.center)
            make.height.width.equalTo(24)
        }
        
        self.shareView.layer.cornerRadius = 10
        self.shareView.snp.makeConstraints { make in
            make.right.equalTo(self.contentView.snp.right).offset(-24)
            make.top.equalTo(self.contentView.safeAreaLayoutGuide.snp.top).offset(24)
            make.width.height.equalTo(40)
        }
        
        self.shareButton.snp.makeConstraints { make in
            make.center.equalTo(self.shareView.snp.center)
            make.height.width.equalTo(24)
        }
        
        self.scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.top.equalTo(self.view.snp.top)
        }
        self.contentView.snp.makeConstraints { make in
            make.edges.equalTo(self.scrollView.snp.edges)
            make.width.equalTo(self.scrollView.snp.width)
            make.height.equalTo(900)
        }
        
        self.detailsView.clipsToBounds = true
        self.detailsView.layer.cornerRadius = 28
        self.detailsView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        self.detailsView.snp.makeConstraints { make in
            make.bottom.equalTo(self.contentView.snp.bottom)
            make.left.equalTo(self.contentView.snp.left)
            make.right.equalTo(self.contentView.snp.right)
            make.top.equalTo(self.imageView.snp.bottom).offset(-32)
        }
        
        self.writtenByView.snp.makeConstraints { make in
            make.left.equalTo(self.detailsView.snp.left).offset(24)
            make.top.equalTo(self.detailsView.snp.top).offset(32)
        }
        
        self.writtenByLabel.snp.makeConstraints { make in
            make.top.equalTo(self.writtenByView.snp.top)
            make.left.equalTo(self.writtenByView.snp.left).offset(8)
            make.right.equalTo(self.writtenByView.snp.right).offset(-8)
            make.bottom.equalTo(self.writtenByView.snp.bottom)
        }
    }
}

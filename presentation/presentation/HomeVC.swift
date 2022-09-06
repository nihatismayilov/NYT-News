//
//  HomeVC.swift
//  presentation
//
//  Created by Nihad Ismayilov on 05.09.22.
//

import Foundation
import SnapKit
import UIKit

public class HomeVC: BaseVC<HomeViewModel> {
    
    lazy var image: UIImageView = {
        let im = UIImageView()
        self.view.addSubview(im)
        return im
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
//        let image = Asset.Media.tabbar4.image
        self.image.image = Asset.Media.tabbar1.image
        self.image.snp.makeConstraints { make in
            make.center.equalTo(self.view.center)
        }
    }
}

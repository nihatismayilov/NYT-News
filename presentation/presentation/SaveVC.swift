//
//  MenuVC.swift
//  presentation
//
//  Created by Nihad Ismayilov on 06.09.22.
//

import Foundation
import UIKit
import SnapKit
import Lottie

public class SaveVC: BaseVC<HomeViewModel> {
    
    lazy var animationView = AnimationView()
    lazy var animationText: UILabel = {
        let lbl = UILabel()
        lbl.text = "You don't have any saved news, yet"
        lbl.font = UIFont(font: FontFamily.NunitoSans.bold, size: 16)
        
        return lbl
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Asset.Colors.backgroundColor.color
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.startAnimation()
    }
    
    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        
        if overrideUserInterfaceStyle == .dark {
            animationView.animation = Animation.named("noFavoritesDark")
        } else {
            animationView.animation = Animation.named("noFavorites")
        }
        self.startAnimation()
    }
}

extension SaveVC {
    func startAnimation() {
        if overrideUserInterfaceStyle == .dark {
            animationView.animation = Animation.named("noFavoritesDark")
        } else {
            animationView.animation = Animation.named("noFavorites")
        }
        animationView.contentMode = .scaleAspectFit
        animationView.animationSpeed = 0.7
        animationView.loopMode = .loop
        animationView.play()
        view.addSubview(animationView)
        animationView.layer.cornerRadius = 24
        animationView.snp.makeConstraints { make in
            make.width.height.equalTo(320)
            make.center.equalTo(self.view.snp.center)
        }
        self.view.addSubview(animationText)
        animationText.snp.makeConstraints { make in
            make.top.equalTo(self.animationView.snp.bottom)
            make.centerX.equalTo(self.animationView.snp.centerX)
        }
    }
}

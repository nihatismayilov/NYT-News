//
//  ActivityVC.swift
//  presentation
//
//  Created by Nihad Ismayilov on 17.09.22.
//

import Foundation
import UIKit
import Lottie

public class ActivityVC: UIViewController {
    var alpha = 0.3
    var animationName = String()
    
    lazy var backView: UIView = {
        let view = UIView()
        self.view.addSubview(view)
        view.backgroundColor = .black
        
        return view
    }()
    
    lazy var animationBackground: UIView = {
        let view = UIView()
        self.view.addSubview(view)
        view.backgroundColor = Asset.Colors.tabbarColor.color
        
        return view
    }()
    
    lazy var animationView = AnimationView()
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupUI()
        self.backView.alpha = alpha
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
        
        if self.traitCollection.userInterfaceStyle == .dark {
            animationName = "loading"
        } else {
            animationName = "loading"
        }
        
        startAnimation()
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = false
        animationView.stop()
    }
    
    func startAnimation() {
        animationView.animation = Animation.named(animationName)
        animationView.loopMode = .loop
        animationView.contentMode = .scaleAspectFit
        
        animationView.play { (finished) in }
    }
    
    func setupUI() {
        self.backView.snp.makeConstraints { make in
            make.top.equalTo(self.view.snp.top)
            make.left.equalTo(self.view.snp.left)
            make.right.equalTo(self.view.snp.right)
            make.bottom.equalTo(self.view.snp.bottom)
        }
        
        animationBackground.layer.cornerRadius = 12
        animationBackground.snp.makeConstraints { make in
            make.center.equalTo(self.view.center)
            make.width.height.equalTo(100)
        }
        
        self.animationBackground.addSubview(animationView)
        animationView.snp.makeConstraints { make in
            make.top.equalTo(self.animationBackground.snp.top).offset(24)
            make.left.equalTo(self.animationBackground.snp.left).offset(24)
            make.right.equalTo(self.animationBackground.snp.right).offset(-24)
            make.bottom.equalTo(self.animationBackground.snp.bottom).offset(-24)
        }
    }
}

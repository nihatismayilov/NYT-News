//
//  SplashScreenVC.swift
//  presentation
//
//  Created by Nihad Ismayilov on 18.09.22.
//

import UIKit
import Lottie

public class SplashScreenVC: BaseVC<HomeViewModel> {
    
    var animationView = AnimationView()

    public override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Asset.Colors.backgroundColor.color

        self.startAnimation()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0, execute: {
            self.changeView()
            print("")
        })
    }
    
    func changeView() {
        let nextVC = self.router?.signInVC()
//        nextVC?.selectedIndex = 2
        nextVC?.modalTransitionStyle = .crossDissolve
        nextVC?.modalPresentationStyle = .fullScreen
        
        self.present(nextVC!, animated: true)
    }
    
    func startAnimation() {
        animationView.animation = Animation.named("launch")
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()
        view.addSubview(animationView)
        animationView.layer.cornerRadius = 16
        animationView.snp.makeConstraints { make in
            make.width.height.equalTo(400)
            make.center.equalTo(self.view.snp.center)
        }
    }
    
    func stopAnimation() {
        animationView.stop()
        animationView.removeFromSuperview()
    }
}

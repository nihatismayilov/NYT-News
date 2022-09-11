//
//  TabbarVC.swift
//  presentation
//
//  Created by Nihad Ismayilov on 05.09.22.
//

import Foundation
import UIKit

public class TabbarVC: BaseTabController<HomeViewModel>  {
    public override func viewDidLoad() {
        super.viewDidLoad()
        let homeVC = router.homeVC()
        let exploreVC = router.exploreVC()
        let saveVC = router.saveVC()
        let profileVC = router.profileVC()
        
        self.view.backgroundColor = Asset.Colors.backgroundColor.color
        
        let homeNav = UINavigationController(rootViewController: homeVC)
        let exploreNav = UINavigationController(rootViewController: exploreVC)
        let saveNav = UINavigationController(rootViewController: saveVC)
        let profileNav = UINavigationController(rootViewController: profileVC)
        
        UITabBar.appearance().barTintColor = Asset.Colors.tabbarColor.color
        tabBar.barStyle = .default
        tabBar.tintColor = Asset.Colors.accentColor.color
        tabBar.unselectedItemTintColor = .lightGray
        tabBar.isTranslucent = false
        tabBar.backgroundColor = Asset.Colors.tabbarColor.color
        
        
        tabBar.clipsToBounds = false
        tabBar.layer.cornerRadius = 28
        tabBar.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        
        tabBar.layer.shadowOffset = CGSize(width: 0, height: 0)
        tabBar.layer.shadowRadius = 5
        tabBar.layer.shadowColor = UIColor.black.cgColor
        tabBar.layer.shadowOpacity = 0.1
        
        homeNav.tabBarItem = UITabBarItem(title: "Home",
                                          image: Asset.Media.tabbar1.image,
                                          selectedImage: Asset.Media.tabbar1Selected.image)
        
        exploreNav.tabBarItem = UITabBarItem(title: "Explore",
                                             image: Asset.Media.tabbar2.image,
                                             selectedImage: Asset.Media.tabbar2.image)
        
        saveNav.tabBarItem = UITabBarItem(title: "Save",
                                          image: Asset.Media.tabbar3.image,
                                          selectedImage: Asset.Media.tabbar3Selected.image)
        
        profileNav.tabBarItem = UITabBarItem(title: "Profile",
                                             image: Asset.Media.tabbar4.image,
                                             selectedImage: Asset.Media.tabbar4Selected.image)
        
        
        
        self.setViewControllers([homeNav, exploreNav, saveNav, profileNav], animated: false)
        
        self.selectedIndex = 0
    }
    
}

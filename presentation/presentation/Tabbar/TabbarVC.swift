//
//  TabbarVC.swift
//  presentation
//
//  Created by Nihad Ismayilov on 05.09.22.
//

import Foundation
import UIKit

public class TabbarVC: UITabBarController {
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.clipsToBounds = false
        tabBar.layer.cornerRadius = 32
        tabBar.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        UITabBar.appearance().barTintColor = Asset.Colors.tabbarColor.color
        tabBar.barStyle = .default
        tabBar.tintColor = .systemBlue
        tabBar.unselectedItemTintColor = .lightGray
        tabBar.isTranslucent = false
        tabBar.backgroundColor = Asset.Colors.tabbarColor.color
        
        
        tabBar.layer.masksToBounds = false
        tabBar.layer.shadowRadius = 2
        tabBar.layer.shadowColor = UIColor.black.cgColor //Asset.Colors.backgroundColor.color
        
        
        let vc1 = HomeNavigationVC()
        
        vc1.tabBarItem.title = "Home"
        vc1.tabBarItem.image = Asset.Media.tabbar1.image
        
        let vc2 = MenuVC()
        
        vc2.tabBarItem.title = "Menu"
//        vc2.tabBarItem.image = Asset.Media.tabbar2.image
        
        let vc3 = SearchVC()
        
        vc3.tabBarItem.title = "Search"
//        vc3.tabBarItem.image = Asset.Media.tabbar3.image
        
        let vc4 = ProfileVC()
        
        vc4.tabBarItem.title = "Profile"
        vc4.tabBarItem.image = Asset.Media.tabbar4.image
        
        self.setViewControllers([vc1, vc2, vc3, vc4], animated: false)
        
        self.selectedIndex = 0
    }
    
}

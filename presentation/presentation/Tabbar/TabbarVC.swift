//
//  TabbarVC.swift
//  presentation
//
//  Created by Nihad Ismayilov on 05.09.22.
//

import Foundation
import UIKit
import Firebase
import FirebaseFirestore

public class TabbarVC: BaseTabController<HomeViewModel>  {
    
    let database = Firestore.firestore()
    
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
        

        
        setupTheme()
//        getSavedNews()
//        self.savePersonalData()
    }
    
    
    func setupTheme() {
        if let theme = APPDefaults.getString(key: "theme") {
            switch theme {
            case "Light":
                UIApplication.shared.windows.first!.overrideUserInterfaceStyle = .light
            case "Dark":
                UIApplication.shared.windows.first!.overrideUserInterfaceStyle = .dark
            default:
                break
            }
        }
    }
    
    func getSavedNews() {
        do {
            if let data = APPDefaults.getData(key: "FavoriteNews") {
                let decoder = try JSONDecoder().decode([DetailsModel].self, from: data)
                DetailsHelper.shared.detailsModelArray = decoder
            } else {
                print("Couldn't load saved News")
            }
        } catch {
            print("Couldn't load saved News")
        }
        
    }
    
    func savePersonalData() {
        if let uuid = Firebase.Auth.auth().currentUser?.uid {
            let nameRef = database.document("\(uuid)/name")
            nameRef.getDocument { snapshot, error in
                guard let data = snapshot?.data(), error == nil else {
                    return
                }
                
                guard let name = data["name"] as? String else {
                    return
                }
                
                APPDefaults.setString(key: "UserName", value: name)
            }
            
            let surnameRef = database.document("\(uuid)/surname")
            surnameRef.getDocument { snapshot, error in
                guard let data = snapshot?.data(), error == nil else {
                    return
                }
                
                guard let surname = data["surname"] as? String else {
                    return
                }
                
                APPDefaults.setString(key: "UserSurname", value: surname)
            }
            
            let mailRef = database.document("\(uuid)/mail")
            mailRef.getDocument { snapshot, error in
                guard let data = snapshot?.data(), error == nil else {
                    return
                }
                
                guard let mail = data["mail"] as? String else {
                    return
                }
                
                APPDefaults.setString(key: "UserMail", value: mail)
            }
            
            let passwordRef = database.document("\(uuid)/password")
            passwordRef.getDocument { snapshot, error in
                guard let data = snapshot?.data(), error == nil else {
                    return
                }
                
                guard let password = data["password"] as? String else {
                    return
                }
                
                APPDefaults.setString(key: "UserPassword", value: password)
            }
            
            let favoritesRef = database.document("\(uuid)/favorites")
            favoritesRef.getDocument { snapshot, error in
                guard let data = snapshot?.data(), error == nil else {
                    return
                }
                
                guard let data = data["favoriteNews"] as? Data else {
                    return
                }
                do {
                    let decoder = try JSONDecoder().decode([DetailsModel].self, from: data)
                    
                    APPDefaults.setData(key: "FavoriteNews", value: data)
                    guard let savedData = APPDefaults.getData(key: "FavoriteNews") else { return }
                    
                    let decoder2 = try JSONDecoder().decode([DetailsModel].self, from: savedData)
                    
                    DetailsHelper.shared.detailsModelArray = decoder2
                } catch {
                    
                }
                
            }
        }
    }
}

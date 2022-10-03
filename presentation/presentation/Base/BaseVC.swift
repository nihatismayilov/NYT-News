//
//  BaseVC.swift
//  presentation
//
//  Created by Nihad Ismayilov on 05.09.22.
//

import Foundation
import UIKit
import Firebase
import FirebaseFirestore

public class BaseVC<VM>: UIViewController {
    
    var vm: VM? = nil
    var router: RouterProtocol? = nil
    let database = Firestore.firestore()
    
    func addActivity(frame: CGRect?) {
        let vc = router?.activityVC()
        vc?.alpha = 0.3
        vc?.hidesBottomBarWhenPushed = true
        self.add(vc!, frame: frame)
    }
    
    func removeActivity() {
        if let cont = self.children.first as? ActivityVC {
            cont.remove()
        } else {
            for i in self.children {
                if let cont = i as? ActivityVC {
                    cont.remove()
                }
            }
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

//
//  AppDelegate.swift
//  NYT-News
//
//  Created by Nihad Ismayilov on 27.08.22.
//

import UIKit
import Swinject
import presentation
import data
import domain
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let assembler = Assembler([
            DomainAssembly(),
            DataAssembly(),
            PresentationAssembly()
        ])
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
//        window?.rootViewController = Router(resolver: assembler.resolver).splashScreenVC()
        
        FirebaseApp.configure()
        if FirebaseAuth.Auth.auth().currentUser != nil {
            window?.rootViewController = Router(resolver: assembler.resolver).tabbarVC()
        } else {
            window?.rootViewController = Router(resolver: assembler.resolver).signInVC()
        }
        
        return true
    }
}


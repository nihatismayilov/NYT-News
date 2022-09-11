////
////  HomeNavigationVC.swift
////  presentation
////
////  Created by Nihad Ismayilov on 06.09.22.
////
//
//import Foundation
//import UIKit
//
//class HomeNavigationVC: UINavigationController, UIGestureRecognizerDelegate {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.view.backgroundColor = Asset.Colors.backgroundColor.color
//        
//        let vc = HomeVC()
//        
//        self.viewControllers = [vc]
//        
//        interactivePopGestureRecognizer?.delegate = self
//        interactivePopGestureRecognizer?.isEnabled = true
//        
////        navigationBar.layer.allowsEdgeAntialiasing = true
//        navigationBar.prefersLargeTitles = true
//        
////        navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
//        vc.navigationItem.title = "Popular News"
//    }
//    
//}

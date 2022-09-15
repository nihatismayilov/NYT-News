//
//  BaseVC.swift
//  presentation
//
//  Created by Nihad Ismayilov on 05.09.22.
//

import Foundation
import UIKit

public class BaseVC<VM>: UIViewController {
    
    var vm: VM? = nil
    var router: RouterProtocol? = nil
    
//    func addActivity(frame: CGRect? = nil) {
//        router.shared.presentActivity { (vc) in
//            vc.alpha = 0.3
//            self.add(vc, frame: frame)
//        }
//    }
//
//    func removeActivity() {
//        if let cont = self.children.first as? ActivityViewController {
//            cont.remove()
//        } else {
//            for i in self.children {
//                if let cont = i as? ActivityViewController {
//                    cont.remove()
//                }
//            }
//        }
//    }
}

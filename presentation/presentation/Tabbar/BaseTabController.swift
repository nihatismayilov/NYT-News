//
//  BaseTabController.swift
//  presentation
//
//  Created by Nihad Ismayilov on 11.09.22.
//

import Foundation
import UIKit

public class BaseTabController<VM>: UITabBarController {
    var vm: VM
    var router:RouterProtocol
    
    init(
        vm: VM,
        router: RouterProtocol
    ) {
        self.vm = vm
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

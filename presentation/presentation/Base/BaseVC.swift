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
}

//
//  ProfileVC.swift
//  presentation
//
//  Created by Nihad Ismayilov on 06.09.22.
//

import Foundation
import UIKit

public class ProfileVC: BaseVC<HomeViewModel> {
    
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Asset.Colors.backgroundColor.color
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.topItem?.title = "Profile"
    }
}

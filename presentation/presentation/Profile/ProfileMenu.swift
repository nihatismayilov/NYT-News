//
//  ProfileMenu.swift
//  presentation
//
//  Created by Nihad Ismayilov on 18.09.22.
//

import Foundation
import UIKit

struct ProfileMenu {
    var title: String
    var description: String
    var icon: UIImage
    
    static var items = [
        ProfileMenu(
            title: "About",
            description: "Click to view",
            icon: Asset.Media.profileInfoIcon.image.withTintColor(Asset.Colors.redWithDark.color)
        ),
        ProfileMenu(
            title: "Terms and Conditions",
            description: "Click to view",
            icon: Asset.Media.profileDocIcon.image.withTintColor(Asset.Colors.redWithDark.color)
        ),
        ProfileMenu(
            title: "Privacy Policy",
            description: "Click to view",
            icon: Asset.Media.profilePrivacyIcon.image.withTintColor(Asset.Colors.redWithDark.color)
        ),
        ProfileMenu(
            title: "Contact us",
            description: "Click to view",
            icon: Asset.Media.profilePhoneIcon.image.withTintColor(Asset.Colors.redWithDark.color)
        ),
        ProfileMenu(
            title: "Logout",
            description: "",
            icon: Asset.Media.profileLogoutIcon.image)
    ]
}

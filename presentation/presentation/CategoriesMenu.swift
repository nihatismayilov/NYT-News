//
//  Model.swift
//  presentation
//
//  Created by Nihad Ismayilov on 14.09.22.
//

import Foundation
import UIKit

struct CategoriesMenu {
    var title: String
    var isSelected: Bool
    var backColor: UIColor
    
    static var items = [
        CategoriesMenu(title: "World", isSelected: false, backColor: Asset.Colors.redColor.color),
        CategoriesMenu(title: "US", isSelected: false, backColor: UIColor.clear),
        CategoriesMenu(title: "Arts", isSelected: false, backColor: UIColor.clear),
        CategoriesMenu(title: "Science", isSelected: false, backColor: UIColor.clear),
        CategoriesMenu(title: "Climate", isSelected: false, backColor: UIColor.clear),
        CategoriesMenu(title: "Business", isSelected: false, backColor: UIColor.clear),
        CategoriesMenu(title: "Technology", isSelected: false, backColor: UIColor.clear)
    ]
}

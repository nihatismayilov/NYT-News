//
//  DetailsHelper.swift
//  presentation
//
//  Created by Nihad Ismayilov on 24.09.22.
//

import Foundation

struct DetailsHelper {
    static var shared = DetailsHelper()
    
    var detailsModelArray: [DetailsModel]? = []
    
    private init() {}
}

//
//  CategorizedNewsRepoProtocol.swift
//  domain
//
//  Created by Nihad Ismayilov on 11.09.22.
//

import Foundation
import Promises

public protocol CategorizedNewsRepoProtocol {
    func getCategorizedNews(with category: String) -> Promise<CategorizedNews>
}

//
//  CategorizedNewsRemoteDataSourceProtocol.swift
//  data
//
//  Created by Nihad Ismayilov on 11.09.22.
//

import Foundation
import Promises

protocol CategorizedNewsRemoteDataSourceProtocol {
    func getCategorizedNews(with category: String) -> Promise<CategorizedNewsResponseDTO>
}

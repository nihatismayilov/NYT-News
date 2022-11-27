//
//  PopularRemoteDataSourceProtocol.swift
//  data
//
//  Created by Nihad Ismayilov on 05.09.22.
//

import Foundation
import Promises

protocol PopularNewsRemoteDataSourceProtocol {
    func getPopularNews() -> Promise<PopularNewsResponseDTO>
}

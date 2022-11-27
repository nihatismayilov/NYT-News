//
//  PopularNewsRepoProtocol.swift
//  domain
//
//  Created by Nihad Ismayilov on 05.09.22.
//

import Foundation
import Promises

public protocol PopularNewsRepoProtocol {
    func getPopularNews() -> Promise<PopularNews>
}

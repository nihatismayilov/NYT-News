//
//  MockData.swift
//  domainTests
//
//  Created by Nihad Ismayilov on 03.10.22.
//

import Foundation
import domain
import Promises

class PopularNewsRepoMockData: PopularNewsRepoProtocol {
    var getPopularNewss = Promise<PopularNews>.pending()
    func getPopularNews() -> Promises.Promise<domain.PopularNews> {
        return getPopularNewss
    }
}

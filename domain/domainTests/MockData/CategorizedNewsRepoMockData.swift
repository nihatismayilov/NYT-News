//
//  CategorizedNewsRepoMockData.swift
//  domainTests
//
//  Created by Nihad Ismayilov on 03.10.22.
//

import Foundation
import domain
import Promises

class CatogorizedNewsRepoMockData: CategorizedNewsRepoProtocol {
    var getCategorizedNewss = Promise<CategorizedNews>.pending()
    
    func getCategorizedNews(with category: String) -> Promises.Promise<domain.CategorizedNews> {
        return getCategorizedNewss
    }
}

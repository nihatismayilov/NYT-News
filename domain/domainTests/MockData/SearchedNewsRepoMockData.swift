//
//  SearchedNewsRepoMockData.swift
//  domainTests
//
//  Created by Nihad Ismayilov on 03.10.22.
//

import Foundation
import domain
import Promises

class SearchedNewsRepoMockData: SearchNewsRepoProtocol {
    var getSearchedNewss = Promise<SearchNews>.pending()
    
    func getSearchNews(with query: String) -> Promises.Promise<domain.SearchNews> {
        return getSearchedNewss
    }
}

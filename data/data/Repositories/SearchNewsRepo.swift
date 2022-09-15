//
//  SearchNewsRepo.swift
//  data
//
//  Created by Nihad Ismayilov on 12.09.22.
//

import Foundation
import domain
import Promises

struct SearchNewsRepo: SearchNewsRepoProtocol {
    private let searchNewsRemoteDataSource: SearchNewsRemoteDataSourceProtocol
    
    init(searchNewsRemoteDataSource: SearchNewsRemoteDataSourceProtocol) {
        self.searchNewsRemoteDataSource = searchNewsRemoteDataSource
    }
    
    func getSearchNews(with query: String) -> Promise<SearchNews> {
        let promise = Promise<SearchNews>.pending()
        
        searchNewsRemoteDataSource.getSearchNews(with: query).then { news in
            promise.fulfill(news.toDomain())
        }
        
        return promise
    }
}

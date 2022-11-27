//
//  CategorizedNewsRepo.swift
//  data
//
//  Created by Nihad Ismayilov on 11.09.22.
//

import Foundation
import domain
import Promises

struct CategorizedNewsRepo: CategorizedNewsRepoProtocol {
    private let categorizedNewsRemoteDataSource: CategorizedNewsRemoteDataSourceProtocol
    init (
        categorizedNewsRemoteDataSource: CategorizedNewsRemoteDataSourceProtocol
    ) {
        self.categorizedNewsRemoteDataSource = categorizedNewsRemoteDataSource
    }
    
    func getCategorizedNews(with category: String) -> Promise<CategorizedNews> {
        let promise = Promise<CategorizedNews>.pending()
        
        categorizedNewsRemoteDataSource.getCategorizedNews(with: category).then { news in
            promise.fulfill(news.toDomain())
        }
        return promise
    }
}

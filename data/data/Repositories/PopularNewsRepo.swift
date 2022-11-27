//
//  PopularNewsRepo.swift
//  data
//
//  Created by Nihad Ismayilov on 05.09.22.
//

import Foundation
import domain
import Promises

struct PopularNewsRepo: PopularNewsRepoProtocol {
    private let popularNewsRemoteDataSource: PopularNewsRemoteDataSourceProtocol
    init (
        popularNewsRemoteDataSource: PopularNewsRemoteDataSourceProtocol
    ) {
        self.popularNewsRemoteDataSource = popularNewsRemoteDataSource
    }
    
    func getPopularNews() -> Promise<PopularNews> {
        let promise = Promise<PopularNews>.pending()
        
        popularNewsRemoteDataSource.getPopularNews().then { popNews in
            promise.fulfill(popNews.toDomain())
        }
        return promise
    }
}

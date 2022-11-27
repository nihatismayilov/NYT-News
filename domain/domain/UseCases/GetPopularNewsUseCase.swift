//
//  GetPopularNewsUseCase.swift
//  domain
//
//  Created by Nihad Ismayilov on 05.09.22.
//

import Foundation
import Promises

public class GetPopularNewsUseCase {
    let repo: PopularNewsRepoProtocol
    
    public init(repo: PopularNewsRepoProtocol) {
        self.repo = repo
    }
    
    public func execute() -> Promise<PopularNews> {
        return repo.getPopularNews()
    }
}

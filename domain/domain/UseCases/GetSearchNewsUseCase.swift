//
//  GetSearchNewsUseCase.swift
//  domain
//
//  Created by Nihad Ismayilov on 12.09.22.
//

import Foundation
import Promises

public class GetSearchNewsUseCase {
    let repo: SearchNewsRepoProtocol
    
    public init(repo: SearchNewsRepoProtocol) {
        self.repo = repo
    }
    
    public func execute(with query: String) -> Promise<SearchNews> {
        return repo.getSearchNews(with: query)
    }
}

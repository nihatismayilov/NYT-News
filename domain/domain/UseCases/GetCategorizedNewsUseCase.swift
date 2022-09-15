//
//  GetCategorizedNewsUseCase.swift
//  domain
//
//  Created by Nihad Ismayilov on 11.09.22.
//

import Foundation
import Promises

public class GetGategorizedNewsUseCase {
    let repo: CategorizedNewsRepoProtocol
    
    public init(repo: CategorizedNewsRepoProtocol) {
        self.repo = repo
    }
    
    public func execute(with category: String) -> Promise<CategorizedNews> {
        return repo.getCategorizedNews(with: category)
    }
}

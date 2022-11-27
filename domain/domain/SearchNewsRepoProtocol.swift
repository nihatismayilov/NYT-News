//
//  SearchNewsRepoProtocol.swift
//  domain
//
//  Created by Nihad Ismayilov on 12.09.22.
//

import Foundation
import Promises

public protocol SearchNewsRepoProtocol {
    func getSearchNews(with query: String) -> Promise<SearchNews>
}

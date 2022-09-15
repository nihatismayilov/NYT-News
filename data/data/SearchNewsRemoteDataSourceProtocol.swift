//
//  SearchNewsRemoteDataSourceProtocol.swift
//  data
//
//  Created by Nihad Ismayilov on 12.09.22.
//

import Foundation
import Promises

protocol SearchNewsRemoteDataSourceProtocol {
    func getSearchNews(with query: String) -> Promise<SearchNewsResponseDTO>
}

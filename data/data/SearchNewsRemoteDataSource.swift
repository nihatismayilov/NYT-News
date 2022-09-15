//
//  SearchNewsRemoteDataSource.swift
//  data
//
//  Created by Nihad Ismayilov on 12.09.22.
//

import Foundation
import Alamofire
import Promises

class SearchNewsRemoteDataSource: SearchNewsRemoteDataSourceProtocol {
    private let networkProvider: Session
    
    init(networkProvider: Session) {
        self.networkProvider = networkProvider
    }
    
    func getSearchNews(with query: String) -> Promise<SearchNewsResponseDTO> {
        let promise = Promise<SearchNewsResponseDTO>.pending()
        
        let url = API.baseUrl + "search/v2/articlesearch.json?q=\(query)&" + API.apiKey
        
        networkProvider.request(url,
                                method: .get)
        .responseDecodable(of: SearchNewsResponseDTO.self) { response in
            if let err = response.error {
                return promise.reject(err)
            }
            
            guard let result = response.value else {return}
            
            promise.fulfill(result)
        }
        
        return promise
    }
}

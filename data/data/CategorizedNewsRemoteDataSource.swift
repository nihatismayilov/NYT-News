//
//  CategorizedNews.swift
//  data
//
//  Created by Nihad Ismayilov on 11.09.22.
//

import Foundation
import Promises
import Alamofire

class CategorizedNewsRemoteDataSource: CategorizedNewsRemoteDataSourceProtocol {
    private let networkProvider: Session
    
    init(networkProvider: Session) {
        self.networkProvider = networkProvider
    }
    
    func getCategorizedNews(with category: String) -> Promise<CategorizedNewsResponseDTO> {
        let promise = Promise<CategorizedNewsResponseDTO>.pending()
        
//        let url = API.baseUrl + "topstories/v2/world.json?" + API.apiKey
        let url = "https://api.nytimes.com/svc/topstories/v2/\(category).json?api-key=ShXA7ArnonYUdMIqaa4aJ1kJD8YwC2FX"
        networkProvider.request(
            url,
            method: .get)
        .responseDecodable(of: CategorizedNewsResponseDTO.self) { response in
            if let err = response.error {
                
                return promise.reject(err)
            }
            
            guard let result = response.value else {return}
            
            promise.fulfill(result)
        }
        return promise
    }
    
    
}

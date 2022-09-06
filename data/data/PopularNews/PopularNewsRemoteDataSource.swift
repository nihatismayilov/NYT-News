//
//  PopularNewsRemoteDataSource.swift
//  data
//
//  Created by Nihad Ismayilov on 05.09.22.
//

import Foundation
import Alamofire
import Promises

class PopularNewsRemoteDataSource: PopularNewsRemoteDataSourceProtocol {
    private let networkProvider: Session
    
    init(networkProvider: Session) {
        self.networkProvider = networkProvider
    }
    
    func getPopularNews() -> Promise<PopularNewsResponseDTO> {
        let promise = Promise<PopularNewsResponseDTO>.pending()
        
        let url = API.baseUrl + "mostpopular/v2/viewed/1.json?" + API.apiKey
        networkProvider.request(
            url,
            method: .get)
        .responseDecodable(of: PopularNewsResponseDTO.self) { response in
            if let err = response.error {
                return promise.reject(err)
            }
            
            switch response.result {
            case .failure(let error):
                promise.reject(error)
            case .success(let popularNews):
                promise.fulfill(popularNews)
            }
        }
        
        return promise
    }
}

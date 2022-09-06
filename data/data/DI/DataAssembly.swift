//
//  DataAssembly.swift
//  data
//
//  Created by Nihad Ismayilov on 05.09.22.
//

import Foundation
import Swinject
import Alamofire
import domain

public class DataAssembly: Assembly {
    public init() {}
    
    public func assemble(container: Container) {
        container.register(Session.self) { _ in
            return AF
        }
        
        container.register(PopularNewsRemoteDataSourceProtocol.self) { r in
            return PopularNewsRemoteDataSource(networkProvider: r.resolve(Session.self)!)
        }
        
        container.register(PopularNewsRepoProtocol.self) { r in
            PopularNewsRepo(popularNewsRemoteDataSource: r.resolve(PopularNewsRemoteDataSourceProtocol.self)!)
        }
    }
}

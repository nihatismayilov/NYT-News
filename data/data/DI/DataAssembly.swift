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
import RealmSwift

public class DataAssembly: Assembly {
    public init() {}
    
    public func assemble(container: Container) {
        container.register(Session.self) { _ in
            return AF
        }
        
        // REALM
        container.register(Realm.self) { r in
            try! Realm(
                configuration: Realm.Configuration(
                    schemaVersion: 0,
                    deleteRealmIfMigrationNeeded: true
                )
            )
        }.inObjectScope(.container)
        
        // Providers
        
        container.register(DatabaseProviderProtocol.self) { r in
            DatabaseProvider(
                realm: r.resolve(Realm.self)!
            )
        }.inObjectScope(.container)
        
        
        container.register(PopularNewsRemoteDataSourceProtocol.self) { r in
            return PopularNewsRemoteDataSource(networkProvider: r.resolve(Session.self)!)
        }
        
        container.register(PopularNewsRepoProtocol.self) { r in
            PopularNewsRepo(popularNewsRemoteDataSource: r.resolve(PopularNewsRemoteDataSourceProtocol.self)!)
        }
        
        container.register(CategorizedNewsRemoteDataSourceProtocol.self) { r in
            return CategorizedNewsRemoteDataSource(networkProvider: r.resolve(Session.self)!)
        }
        
        container.register(CategorizedNewsRepoProtocol.self) { r in
            CategorizedNewsRepo(categorizedNewsRemoteDataSource: r.resolve(CategorizedNewsRemoteDataSourceProtocol.self)!)
        }
        
        container.register(SearchNewsRemoteDataSourceProtocol.self) { r in
            return SearchNewsRemoteDataSource(networkProvider: r.resolve(Session.self)!)
        }
        
        container.register(SearchNewsRepoProtocol.self) { r in
            SearchNewsRepo(searchNewsRemoteDataSource: r.resolve(SearchNewsRemoteDataSourceProtocol.self)!)
        }
    }
}

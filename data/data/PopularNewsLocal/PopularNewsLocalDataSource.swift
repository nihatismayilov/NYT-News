//
//  PopularNewsLocalDataSource.swift
//  data
//
//  Created by Nihad Ismayilov on 26.09.22.
//

import Foundation
import Combine

class PopularNewsLocalDataSource: PopularNewsLocalDataSourceProtocol {
    
    let popularNewsSubject: CurrentValueSubject<[PopularNewsLocalDTO], Never>
    let databaseProvider: DatabaseProviderProtocol
    
    init(databaseProvider: DatabaseProviderProtocol) {
        self.databaseProvider = databaseProvider
        self.popularNewsSubject = .init(databaseProvider.read())
    }
    
    func removeAll() throws {
        try self.databaseProvider.deleteAll(of: PopularNewsLocalDTO.self)
    }
    
    func removeAll(when: @escaping (PopularNewsLocalDTO) -> Bool) throws {
        try self.databaseProvider.delete(of: PopularNewsLocalDTO.self, when: when)
    }
    
    func save(title: String, topStories: [PopularNewsLocalDTO]) throws {
        try self.databaseProvider.delete(of: PopularNewsLocalDTO.self, when: {
            $0.title == title
        })
        try self.databaseProvider.write(objects: topStories)
        self.popularNewsSubject.send(topStories)
    }
    
    func getPopularNews() -> [PopularNewsLocalDTO] {
        self.databaseProvider.read()
    }
    
    func getPopularNews(when: (PopularNewsLocalDTO) -> Bool) -> [PopularNewsLocalDTO] {
        self.databaseProvider.read().filter(when)
    }
    
    func observePopularNews() -> AnyPublisher<[PopularNewsLocalDTO], Never> {
        self.popularNewsSubject.eraseToAnyPublisher()
    }
}

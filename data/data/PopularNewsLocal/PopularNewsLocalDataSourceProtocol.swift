//
//  PopularNewsLocalDataSourceProtocol.swift
//  data
//
//  Created by Nihad Ismayilov on 26.09.22.
//

import Foundation
import Combine

protocol PopularNewsLocalDataSourceProtocol {
    func removeAll() throws
    func removeAll(when: @escaping (PopularNewsLocalDTO) -> Bool) throws
    func save(title: String, topStories: [PopularNewsLocalDTO]) throws
    func getPopularNews() -> [PopularNewsLocalDTO]
    func getPopularNews(when: @escaping (PopularNewsLocalDTO) -> Bool) -> [PopularNewsLocalDTO]
    func observePopularNews() -> AnyPublisher<[PopularNewsLocalDTO], Never>
}

//
//  DatabaseProviderProtocol.swift
//  data
//
//  Created by Nihad Ismayilov on 26.09.22.
//

import Foundation
import Realm
import RealmSwift

protocol DatabaseProviderProtocol {
    func read<T: Object>() -> [T]
    func write<T: Object>(objects: [T]) throws
    func deleteAll<T: Object>(of: T.Type) throws
    func delete<T: Object>(of: T.Type, when: @escaping (T) -> Bool) throws
    func deleteAll() throws
    
    func cache<T: Codable>(data: T, key: String)
    func getCache<T: Codable>(key: String) -> T?
}

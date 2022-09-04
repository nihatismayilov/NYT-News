//
//  LocalDataStorage.swift
//  data
//
//  Created by Nihad Ismayilov on 02.09.22.
//

import Foundation
import Promises
import domain

open class LocalDataStorage {
    // MARK: - Variables
    
    private let userDefaults: UserDefaults
    
    let logger: Logger
    
    // MARK: - Constructor
    
    init(logger: Logger) {
        self.userDefaults = UserDefaults.standard
        self.logger = logger
    }
    
    // MARK: - Functions
    
    // for data
    func cache<T: Encodable>(key: String, data: T) {
        if let encoded = try? JSONEncoder().encode(data) {
            self.userDefaults.set(encoded, forKey: key)
        } else {
            logger.logDebug("Not saved \(T.self)")
        }
    }
    
    // for string
    func cache(key: String, value: String) {
        self.userDefaults.set(value, forKey: key)
    }
    
    // for int
    func cache(key: String, value: Int) {
        self.userDefaults.set(value, forKey: key)
    }
    
    // get for data
    func getCached<T: Decodable>(key: String) -> T? {
        if let data = self.userDefaults.object(forKey: key) as? Data {
            return try? JSONDecoder().decode(T.self, from: data)
        }
        
        return nil
    }
    
    // get for string
    func getCachedString(key: String) -> String? {
        return self.userDefaults.string(forKey: key)
    }
    
    // get for int
    func getCachedInt(key: String) -> Int? {
        return self.userDefaults.integer(forKey: key)
    }
    
    // get for double
    func getCachedDouble(key: String) -> Double? {
        return self.userDefaults.double(forKey: key)
    }
    
    // remove with key
    func removeCachedValue(key: String) {
        self.userDefaults.removeObject(forKey: key)
    }
}

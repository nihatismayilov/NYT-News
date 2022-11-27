//
//  AppDefaults.swift
//  presentation
//
//  Created by Nihad Ismayilov on 23.09.22.
//

import Foundation

class APPDefaults {
    
    private static let defaults = UserDefaults.standard
    
    // MARK: Setters
    static func setObject(key: String, value: AnyObject) {
        defaults.set(value, forKey: key)
        defaults.synchronize()
    }
    
    static func setString(key: String, value: String?) {
        defaults.set(value, forKey: key)
        defaults.synchronize()
    }
    
    static func setInteger(key: String, value: Int) {
        defaults.set(value, forKey: key)
        defaults.synchronize()
    }
    
    static func setDouble(key: String, value: Double) {
        defaults.set(value, forKey: key)
        defaults.synchronize()
    }
    
    static func setFloat(key: String, value: Float) {
        defaults.set(value, forKey: key)
        defaults.synchronize()
    }
    
    static func setBool(key: String, value: Bool) {
        defaults.set(value, forKey: key)
        defaults.synchronize()
    }
    
    static func setDate(key: String, value: Date) {
        defaults.set(value, forKey: key)
        defaults.synchronize()
    }
    
    static func setData(key: String, value: Data) {
        defaults.set(value, forKey: key)
        defaults.synchronize()
    }
    
    static func setArray(key: String, value: [String]) {
        defaults.set(value, forKey: key)
        defaults.synchronize()
    }
    
    // MARK: Getters
    static func getObject(key: String) -> AnyObject? {
        return defaults.object(forKey: key) as AnyObject?
    }
    
    static func getString(key: String) -> String? {
        return defaults.object(forKey: key) as? String
    }
    
    static func getInteger(key: String) -> Int {
        return defaults.integer(forKey: key)
    }
    
    static func getDouble(key: String) -> Double {
        return defaults.double(forKey: key)
    }
    
    static func getFloat(key: String) -> Float {
        return defaults.float(forKey: key)
    }
    
    static func getBool(key: String) -> Bool {
        return defaults.bool(forKey: key)
    }
    
    static func getDate(key: String) -> Date? {
        return defaults.object(forKey: key) as? Date
    }
    
    static func getData(key: String) -> Data? {
        return defaults.data(forKey: key)
    }
    
    static func getArray(key: String) -> [String]? {
        return defaults.stringArray(forKey: key)
    }
    
    // MARK: Remover
    static func remove(key: String) {
        defaults.removeObject(forKey: key)
        defaults.synchronize()
    }
}

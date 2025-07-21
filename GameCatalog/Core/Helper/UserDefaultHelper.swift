//
//  UserDefaultHelper.swift
//  GameCatalog
//
//  Created by Heri Sandiyadi on 14/07/25.
//

import Foundation

struct UserDefaultsHelper {
    
    static func save<T: Codable>(value: T, forKey key: String) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(value) {
            UserDefaults.standard.set(encoded, forKey: key)
        }
    }
    
    static func get<T: Codable>(forKey key: String, type: T.Type) -> T? {
        if let data = UserDefaults.standard.data(forKey: key) {
            let decoder = JSONDecoder()
            return try? decoder.decode(T.self, from: data)
        }
        return nil
    }
    
    static func remove(forKey key: String) {
        UserDefaults.standard.removeObject(forKey: key)
    }
}

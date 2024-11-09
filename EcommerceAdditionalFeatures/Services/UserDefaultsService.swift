//
//  UserDefaultsService.swift
//  EcommerceAdditionalFeatures
//
//  Created by muhammed dursun on 9.11.2024.
//

import Foundation


struct UserDefaultsService {
    
    static let instance = UserDefaultsService()
    private let defaults = UserDefaults.standard
    private let jsonDecoder = JSONDecoder()
    private let jsonEncoder = JSONEncoder()
    
    private init() { }
    
    
    func save<T: Codable>(_ object: T, key: UserDefaultsKey) {
        guard let encoded = try? jsonEncoder.encode(object) else {
            return
        }
        
        defaults.setValue(encoded, forKey: key.rawValue)
    }
    
    
    func save(_ object: Int, key: UserDefaultsKey) {
        defaults.setValue(object, forKey: key.rawValue)
    }
    
    
    private func fetch<T: Codable>(key: UserDefaultsKey) -> T? {
        guard let data = defaults.object(forKey: key.rawValue) as? Data else {
            return nil
        }
        
        return try? jsonDecoder.decode(T.self, from: data)
    }
    
    
    func remove(key: UserDefaultsKey) {
        defaults.removeObject(forKey: key.rawValue)
        defaults.synchronize()
    }
    
    
    ///Login olmuş olan kullanıcı var ise bilgilerini alabiliriz.
    var currentUser: User? {
        fetch(key: .user)
    }
}

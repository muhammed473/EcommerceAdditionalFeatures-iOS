//
//  ParserService.swift
//  EcommerceAdditionalFeatures
//
//  Created by muhammed dursun on 9.11.2024.
//

import FirebaseFirestore



struct ParserService {
    
    static let instance = ParserService()
    
    
    private init() {
        
    }
    
    
    func parseToUser(snapshot: DocumentSnapshot?) -> User? {
        guard let snapshot = snapshot else {
            return nil
        }
        
        return User(
            uid: snapshot.documentID,
            name: snapshot.get("name") as? String,
            surname: snapshot.get("surname") as? String,
            email: snapshot.get("email") as? String
        )
    }
}


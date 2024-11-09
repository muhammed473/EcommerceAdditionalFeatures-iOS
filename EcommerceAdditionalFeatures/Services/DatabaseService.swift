//
//  DatabaseService.swift
//  EcommerceAdditionalFeatures
//
//  Created by muhammed dursun on 9.11.2024.
//

import FirebaseFirestore
import FirebaseCore


struct DatabaseService: Service {
    
    static let instance = DatabaseService()
    private let db = Firestore.firestore()
    
    
    private init() {
        
    }
    
    
    func saveUser(user: User, completion: Handler?) {
        guard let uid = user.uid else {
            return
        }
        
        db.collection("Users").document(uid).setData(user.dictionary) { error in
            if let error = error {
                show(message: error.localizedDescription, type: .error)
                return
            }
            
            UserDefaultsService.instance.save(user, key: .user)
            
            completion?()
        }
    }
    
    
    func fetchUser(uid: String, completion: Callback<User>?) {
        db.collection("Users").document(uid).getDocument { snapshot, error in
            if let error = error {
                show(message: error.localizedDescription, type: .error)
                return
            }
            
            guard let user = ParserService.instance.parseToUser(snapshot: snapshot) else {
                show(message: "Cannot parsed.", type: .error)
                return
            }
            
            UserDefaultsService.instance.save(user, key: .user)
            
            completion?(user)
        }
    }
    
    
    func addLoveUser(currentUser: User?, email: String, completion: Handler?) {
        guard let user = currentUser, let userId = user.uid else {
            print("Error: Current user or UID is nil.")
            completion?()
            return
        }
        
        db.collection("Users").document((currentUser?.uid!)!).updateData(["partner": FieldValue.arrayUnion([email])]) { error in
            if let error = error{
                print("Error adding email.")
            }
            else{
                print("Success adding email.")
            }
            completion?()
        }
    }
}

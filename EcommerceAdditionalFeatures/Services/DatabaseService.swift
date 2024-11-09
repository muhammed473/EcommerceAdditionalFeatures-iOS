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
    
    /// Kullanıcı bilgilerini kaydetmek kullanılır.
    ///
    /// - Parameters:
    ///   - user: Kaydedeciğimiz user'ın modelleşmiş halidir. 'uid' alanı mutlaka dolu olmalıdır.
    ///   - completion: Başarılı kaydı ifade eder.
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
    
    
    /// Kullanıcı bilgilerini kaydetmek kullanılır.
    ///
    /// - Parameters:
    ///   - uid: Bilgilerini istediğimiz kullanıcının Authentication uid'sidir.
    ///   - completion: Başarılı işlemdir ve User modeli döner.
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
    
}

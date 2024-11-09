//
//  AuthService.swift
//  EcommerceAdditionalFeatures
//
//  Created by muhammed dursun on 9.11.2024.
//

import FirebaseAuth


struct AuthService: Service {
    
    static let instance = AuthService()
    private let auth = Auth.auth()
    
    
    private init() {}
    
    
    /// Kullanıcı kaydı için kullanılır.
    ///
    /// - Parameters:
    ///   - completion: Kayıt başarılı ise kaydedilen kullanıcının uid değerini döner.
    func registerUser(email: String, password: String, completion: Callback<String>?) {
        auth.createUser(withEmail: email, password: password) { result, error in
            if let uid = result?.user.uid {
                completion?(uid)
                return
            }
            
            show(message: error?.localizedDescription, type: .error)
        }
    }
    
    
    /// Kullanıcı login yapmak için kullanırız.
    ///
    /// - Parameters:
    ///   - completion: Giriş başarılı ise kullanıcının uid değerini döner.
    func login(email: String, password: String, completion: Callback<String>?) {
        auth.signIn(withEmail: email, password: password) { result, error in
            if let uid = result?.user.uid {
                completion?(uid)
                return
            }
            
            show(message: error?.localizedDescription, type: .error)
        }
    }
    
    
    /// Kullanıcı logout yapmak için kullanırız.
    /// - Parameters:
    ///   - completion: Çıkış başarılı ise çalışır
    func logOut(completion: Handler?) {
        do {
            try Auth.auth().signOut()
            UserDefaultsService.instance.remove(key: .user)
            completion?()
            
        } catch let signOutError as NSError {
            show(message: signOutError.localizedDescription, type: .error)
        }
    }
}

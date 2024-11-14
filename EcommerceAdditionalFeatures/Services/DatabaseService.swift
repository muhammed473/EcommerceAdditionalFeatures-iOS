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
        
        db.collection("Users").whereField("email", isEqualTo: email).getDocuments { snapshot, error in
            guard let snapshot = snapshot, !snapshot.isEmpty, let document = snapshot.documents.first else {
                completion?()
                return
            }
            
            let loveUid = document.documentID
            
            db.collection("Users").document(userId).updateData(["partner": FieldValue.arrayUnion([email])]) { error in
                if let error = error {
                    print("Error adding email to partner array: \(error)")
                } else {
                    print("Email added to partner array successfully.")
                    
                    db.collection("Users").document(loveUid).updateData(["isEmailConfirmed": false]) { error in
                        if let error = error {
                            print(" isEmailConfirmed is not add  : \(error)")
                        }
                        else {
                            show(message: "isEmailConfirmed is add success...", type: .success)
                            
                            db.collection("Users").document(loveUid).updateData(["partner": FieldValue.arrayUnion([user.email])]) { error in
                                if let error = error {
                                    show(message: "Hata: \(error.localizedDescription)", type: .error)
                                } else {
                                    // Başarı durumunda mesaj göster
                                    show(message: "Partner e-posta başarıyla eklendi.", type: .success)
                                }
                            }
                        }
                    }
                }
            }
            
            completion?()
        }
    }
    
    
    func checkEmailConfirmation(completion: Callback<Bool>?) {
        guard let userUid = UserDefaultsService.instance.currentUser?.uid else {
            show(message: "User is not found..", type: .error)
            return
        }
        
        db.collection("Users").document(userUid).getDocument { snapshot, error in
            guard let snapshot = snapshot else {
                return
            }
            
            guard  let data = snapshot.data(), let isEmailConfirmed = data["isEmailConfirmed"] as? Bool else {
                return
            }
            completion?(isEmailConfirmed)
        }
    }
    
    
    func myConfirmEmail(completion: Handler?) {
        guard let userUid = UserDefaultsService.instance.currentUser?.uid else {
            show(message: "Kullanıcı bulunamadı.", type: .error)
            return
        }
        
        db.collection("Users").document(userUid).updateData(["isEmailConfirmed": true]) { error in
            if let error = error {
                print("Error updating confirmation: \(error)")
            } else {
                print("Email confirmed!")
                completion?()
            }
            completion?()
            
            
        }
    }
    
    
    func addedTheMailInformation(completion: Callback<String>?) {
        guard let userUid = UserDefaultsService.instance.currentUser?.uid else {
            show(message: "User is not found..", type: .error)
            return
        }
        
        db.collection("Users").document(userUid).getDocument { snapshot, error in
            guard let snapshot = snapshot else {
                return
            }
            
            if let data = snapshot.data(),
               let email = data["email"] as? String,
               let partners = data["partner"]  as? [String]{
                
                if let partnerEmail = partners.first(where: { $0 != email }) {
                    // partner'ı bulduk
                    self.fetchPartnerInfo(partnerEmail: partnerEmail, completion: completion)
                } else {
                    show(message: "No matching partner found", type: .error)
                }
            }  else {
                show(message: "User data is incomplete", type: .error)
            }
        }
    }
    
    
    func fetchPartnerInfo(partnerEmail: String, completion: Callback<String>?) {
        // Partner'ın bilgilerini almak için ikinci sorguyu yapıyoruz :
        db.collection("Users").whereField("email", isEqualTo: partnerEmail).getDocuments { snapshot, error in
            guard let snapshot = snapshot, error == nil else {
                return
            }
            
            if let document = snapshot.documents.first {
                let data = document.data()
                // Partnerin bilgileri bulundu
                let name = data["name"] as? String ?? "No name"
                let surname = data["surname"] as? String ?? "No surname"
                let email = data["email"] as? String ?? "No email"
                
                // Partnerin bilgilerini istediğin şekilde kullanabilirsin
                print("Partner Info: \(name) \(surname), \(email)")
                completion?(email)
            } else {
                show(message: "Partner not found in database", type: .error)
            }
            
        }
    }
    
    
    
    
}

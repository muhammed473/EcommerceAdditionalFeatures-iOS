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
                        }
                    }
                }
            }
            
            completion?()
        }
    }
    
    
    func checkEmailConfirmation(completion: Handler?) {
        guard let userUid = UserDefaultsService.instance.currentUser?.uid else {
            show(message: "User is not found..", type: .error)
            return
        }
        
        db.collection("Users").document(userUid).getDocument { snapshot, error in
            guard let snapshot = snapshot else {
                return
            }
            
            if let data = snapshot.data(), let isEmailConfirmed = data["isEmailConfirmed"] as? Bool{
                
                if isEmailConfirmed {
                    show(message: "E-mail confirmed.", type: .success)
                } else {
                    let noAction = AlertModel(title: "No")
                    
                    let yesAction = AlertModel(title: "Yes") {
                        self.myConfirmEmail(completion:completion)
                    }
                    
                    showAlert(type: .warning, message: "Someone added you as an e-mail, do you accept it?", actions: [noAction, yesAction])
                }
            } 
            else {
                show(message: "isEmailConfirmed field is not found.", type: .error)
                completion?()
                return
            }
            
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
                print("Mehmet's email confirmed!")
                completion?()
            }
        }
    }
    
    
    
    
}



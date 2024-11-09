//
//  SignInViewModel.swift
//  EcommerceAdditionalFeatures
//
//  Created by muhammed dursun on 9.11.2024.
//

class SignInViewModel: ViewModel {
    
    
    func signIn(email: String, password: String, completion: Callback<User>?) {
        guard !email.isEmpty, !password.isEmpty else {
            return
        }
        
        showLoading()
        
        AuthService.instance.login(email: email, password: password) { uid in
            DatabaseService.instance.fetchUser(uid: uid) { user in
                self.hideLoading()
                completion?(user)
            }
        }
    }
}

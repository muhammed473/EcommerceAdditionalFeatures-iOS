//
//  MainViewModel.swift
//  EcommerceAdditionalFeatures
//
//  Created by muhammed dursun on 9.11.2024.
//

class MainViewModel: ViewModel {
    
    
    func fetchUser(completion: Callback<User>?) {
        guard let user = UserDefaultsService.instance.currentUser else {
            return
        }
        completion?(user)
    }
    
    
    func loveEmailAdd(email: String, completion: Handler?) {
        fetchUser { user in
            DatabaseService.instance.addLoveUser(currentUser: user, email: email, completion: completion)
        }
    }
    
    
    func checkSomeOneAddedEmail(completion: Handler?) {
        DatabaseService.instance.checkEmailConfirmation(completion: completion)
    }
    
   
}




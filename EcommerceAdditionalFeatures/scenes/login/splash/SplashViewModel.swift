//
//  SplashViewModel.swift
//  EcommerceAdditionalFeatures
//
//  Created by muhammed dursun on 9.11.2024.
//

class SplashViewModel: ViewModel {
        
    
    var currentUser: User? {
        UserDefaultsService.instance.currentUser
    }
}

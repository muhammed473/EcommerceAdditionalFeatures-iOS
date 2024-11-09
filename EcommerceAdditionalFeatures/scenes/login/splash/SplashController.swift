//
//  SplashController.swift
//  EcommerceAdditionalFeatures
//
//  Created by muhammed dursun on 9.11.2024.
//

import Foundation


class SplashController: Controller<SplashViewModel, LoginNavigationController> {
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        viewModel.showLoading()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: checkCurrentUser)
    }
    
    
    private func checkCurrentUser() {
        viewModel.hideLoading()
        
        if let currentUser = viewModel.currentUser {
            navController?.leaveFromLogin()
            return
        }
        
        navController?.splashToSignIn()
    }
}

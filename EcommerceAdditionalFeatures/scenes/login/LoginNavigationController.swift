//
//  LoginNavigationController.swift
//  EcommerceAdditionalFeatures
//
//  Created by muhammed dursun on 9.11.2024.
//

class LoginNavigationController: NavigationController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       isNavigationBarHidden = true
        
        let signInController = SignInController()
        viewControllers = [signInController]
    }
    
    
    func splashToSignIn() {
        let signInController = SignInController()
        pushViewController(signInController, animated: true)
        
        viewControllers.removeAll{
            $0 is SplashController
        }
    }
    
    
    func signInToSignUp() {
        let signUpController = SignUpController()
        pushViewController(signUpController, animated: true)
    }
    
    
    func signUpToSignIn() {
       popViewController(animated: true)
    }
    
    
    func leaveFromLogin() {
        let mainController = MainController()
        mainController.modalPresentationStyle = .fullScreen
        present(mainController, animated: true, completion: nil)
    }
}

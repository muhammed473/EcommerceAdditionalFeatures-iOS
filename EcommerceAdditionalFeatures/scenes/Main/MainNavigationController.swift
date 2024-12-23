//
//  MainNavigationController.swift
//  EcommerceAdditionalFeatures
//
//  Created by muhammed dursun on 9.11.2024.
//

class MainNavigationController: NavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let rootController = MainController()
        viewControllers = [rootController]
    }
    
    func gec(urun: String) {
        let matchedController = MatchedController()
        present(matchedController, animated: true)
    }
}

//
//  MatchedNavigationController.swift
//  EcommerceAdditionalFeatures
//
//  Created by muhammed dursun on 9.12.2024.
//

class MatchedNavigationController: NavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let rootController = MatchedController()
        viewControllers = [rootController]
    }
}

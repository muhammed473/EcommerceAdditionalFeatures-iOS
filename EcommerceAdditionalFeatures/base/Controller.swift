//
//  Controller.swift
//  EcommerceAdditionalFeatures
//
//  Created by muhammed dursun on 9.11.2024.
//

import UIKit


class Controller<VM: ViewModel, NC: NavigationController>: UIViewController {
   
    lazy var viewModel = VM()
    
    
    override func loadView() {
        super.loadView()
        
        view.backgroundColor = UIColor(named: "snow")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customizeViews()
    }
    
    
    func customizeViews() {
        
    }
    
    
    var navController: NC? {
        navigationController as? NC
    }
    
    
    func addSubviews(_ subview: UIView...) {
        subview.forEach {
            view.addSubview($0)
        }
    }
    
    
    func activateConstraints(_ constraints: NSLayoutConstraint...) {
        NSLayoutConstraint.activate(constraints)
    }
}

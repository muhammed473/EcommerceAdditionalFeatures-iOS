//
//  MainController.swift
//  EcommerceAdditionalFeatures
//
//  Created by muhammed dursun on 9.11.2024.
//

import UIKit

class MainController: Controller<MainViewModel, MainNavigationController> {
    
    private let emailText = TextFieldLayout()
    private let addButton = ButtonSecondary()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        addSubviews(emailText, addButton)
        
        activateConstraints(
            emailText.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            emailText.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            addButton.topAnchor.constraint(equalTo: emailText.bottomAnchor, constant: 25),
            addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        )
        
    //   a()
    }
    
    
    override func customizeViews() {
        addButton.setTitle("Email Add", for: .normal)
        addButton.action = addButtonClicked
    }
    
    
    private func addButtonClicked() {
        guard let email = emailText.text, !email.isEmpty else {
            return
        }
        
        viewModel.loveEmailAdd(email: email) {
            self.viewModel.show(message: "Partner is mail added.", type: .success)
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.checkSomeOneAddedEmail { isEmailConfirmed in
            if isEmailConfirmed {
                self.viewModel.show(message: "E-mail confirmed", type: .success)
            }
            else {
                let noAction = AlertModel(title: "No")
                
                let yesAction = AlertModel(title: "Yes") {
                    self.viewModel.confirmControl {
                        let productsController = ProductsController()
                        productsController.modalPresentationStyle = .fullScreen
                        self.present(productsController, animated: true, completion: nil)
                        
                    }
                }
                self.viewModel.getAddedTheMailInformation { partnerEmail in
                    self.viewModel.showAlert(type: .warning, message: "\(partnerEmail) mailine sahip kişi sana davet gönderdi.Partnerinle ortak ürün zevklerini bulmaya var mısın? ", actions: [noAction, yesAction])
                }
                
            }
        }
        
    }
    
    
}






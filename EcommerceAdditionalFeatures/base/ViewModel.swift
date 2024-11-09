//
//  ViewModel.swift
//  EcommerceAdditionalFeatures
//
//  Created by muhammed dursun on 9.11.2024.
//

class ViewModel {
    
    required init() {
        
    }
    
    
    func show(message: String?, type: AlertType) {
        let okAction = AlertModel(title: "Okay")
        AlertView.instance.show(type: type, message: message, actions: [okAction])
    }
    
    
    /// Loading göstermek için kullanırız.
    func showLoading() {
        LoadingView.instance.show()
    }
    
    
    /// Loading gizlemek için kullanırız.
    func hideLoading() {
        LoadingView.instance.hide()
    }
    
    
    func showAlert(type: AlertType, message: String?, actions: [AlertModel]) {
        AlertView.instance.show(type: type, message: message, actions: actions)
    }
}

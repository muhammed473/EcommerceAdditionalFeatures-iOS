//
//  Enums.swift
//  EcommerceAdditionalFeatures
//
//  Created by muhammed dursun on 9.11.2024.
//

import UIKit


enum AlertType {
    case success
    case error
    case warning
    
    var icon: UIImage? {
        switch self {
        case .success:
            return .iconSuccess
            
        case .error:
            return .iconError
            
        case .warning:
            return .iconWarning
        }
    }
    
    
    var tintColor: UIColor? {
        switch self {
        case .success:
            return UIColor(named: "success")
            
        case .error:
            return UIColor(named: "error")
            
        case .warning:
            return UIColor(named: "warning")
        }
    }
    
    
    var title: String? {
        switch self {
        case .success:
            return "Success"
            
        case .error:
            return "Error"
            
        case .warning:
            return "Warning"
        }
    }
}

enum UserDefaultsKey: String {
    case user = "user"
}


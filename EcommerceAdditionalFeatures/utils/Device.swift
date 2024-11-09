//
//  Device.swift
//  EcommerceAdditionalFeatures
//
//  Created by muhammed dursun on 9.11.2024.
//

import UIKit


struct Device {
    
    static let bounds = UIScreen.main.bounds
    static let size = bounds.size
    static let width = size.width
    static let height = size.height
    static let isAnIpad = UIDevice.current.userInterfaceIdiom == .pad
}

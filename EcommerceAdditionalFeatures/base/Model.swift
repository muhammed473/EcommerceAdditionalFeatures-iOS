//
//  Model.swift
//  EcommerceAdditionalFeatures
//
//  Created by muhammed dursun on 9.11.2024.
//

struct AlertModel {
    let title: String?
    var action: Handler?
}


struct User: Codable {
    let uid: String?
    let name: String?
    let surname: String?
    let email: String?
}

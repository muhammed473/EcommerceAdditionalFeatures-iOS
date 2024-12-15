//
//  ProductsController.swift
//  EcommerceAdditionalFeatures
//
//  Created by muhammed dursun on 11.11.2024.
//

import UIKit

class ProductsController: Controller<ProductsViewModel, MainNavigationController> {
    
    let items: [Products] = [
        .init(uid: nil, productName: "Kazak",productImageUrl: "kazak", productPrice: "220TL"),
        .init(uid: nil, productName: "Gömlek",productImageUrl:  "gömlek", productPrice: "300TL"),
        .init(uid: nil, productName: "Pantolon",productImageUrl: "pantalon", productPrice: "400TL"),
        .init(uid: nil, productName: "Ayakkabı",productImageUrl:  "ayakkabı", productPrice: "990TL"),
        .init(uid: nil, productName: "Çorap",productImageUrl:  "Çorap", productPrice: "75TL"),
        .init(uid: nil, productName: "Atlet",productImageUrl:  "atlet", productPrice: "100TL"),
        .init(uid: nil, productName: "Eşofman",productImageUrl:  "esofman", productPrice: "350TL"),
        .init(uid: nil, productName: "Cüzdan",productImageUrl: "cüzdan", productPrice: "190TL"),
    ]
   
    private let collectionView = ProductsCollectionView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        addSubviews(collectionView)
       
        collectionView.setItems(items: items)
        
        activateConstraints(
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        )
    }
    
 
    func handlerMatchedProduct(name: String) {
        print("Name: \(name)")
        let matchedController = MatchedController(urun: name)
        present(matchedController, animated: true)
    }
    
}

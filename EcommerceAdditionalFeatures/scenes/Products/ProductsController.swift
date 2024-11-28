//
//  ProductsController.swift
//  EcommerceAdditionalFeatures
//
//  Created by muhammed dursun on 11.11.2024.
//

import UIKit

class ProductsController: Controller<ProductsViewModel, MainNavigationController> {
    
    let items: [Products] = [
        .init(uid: nil, productName: "Kazak",/*productImage: UIImage(named: "kazak")*/ productPrice: "220TL"),
        .init(uid: nil, productName: "Gömlek",/*productImage: UIImage(named: "gömlek"),*/ productPrice: "300TL"),
        .init(uid: nil, productName: "Pantolon",/*productImage: UIImage(named: "pantalon"),*/ productPrice: "400TL"),
        .init(uid: nil, productName: "Ayakkabı",/*productImage: UIImage(named: "ayakkabı"),*/ productPrice: "990TL"),
        .init(uid: nil, productName: "Çorap",/*productImage: UIImage(named: "Çorap"),*/ productPrice: "75TL"),
        .init(uid: nil, productName: "Atlet",/*productImage: UIImage(named: "atlet"),*/ productPrice: "100TL"),
        .init(uid: nil, productName: "Eşofman",/*productImage: UIImage(named: "esofman"),*/ productPrice: "350TL"),
        .init(uid: nil, productName: "Cüzdan",/*productImage: UIImage(named: "cüzdan"),*/ productPrice: "190TL"),
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
    
    
    private func onItemClicked(item: Products) {
        print(item.productName!)
        print("Şu ürünü beğendi : \(item.productName)")
    }
}

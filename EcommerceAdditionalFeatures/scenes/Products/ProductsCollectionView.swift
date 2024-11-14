//
//  ProductsCollectionView.swift
//  EcommerceAdditionalFeatures
//
//  Created by muhammed dursun on 14.11.2024.
//

class ProductsCollectionView: CollectionView<Products, ProductsCollectionViewCell, ProductsFlowLayout> {
    
}



class ProductsCollectionViewCell: CollectionViewCell<Products> {
    
    private let productNameLabel = Label()
    private let productImage = ImageView()
    private let productPrice = Label()
    
    
    override func configure() {
        backgroundColor = .lightGray
        layer.cornerRadius = 10
        
        contentView.addSubview(productNameLabel)
        contentView.addSubview(productPrice)
        contentView.addSubview(productImage)
        
        
        activateConstraints(
            productImage.safeAreaLayoutGuide.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 25),
            productImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 15),
            productImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            
            productNameLabel.topAnchor.constraint(equalTo: productImage.bottomAnchor, constant: 10),
            productNameLabel.leadingAnchor.constraint(equalTo: productImage.leadingAnchor),
            
            productPrice.topAnchor.constraint(equalTo: productNameLabel.bottomAnchor, constant: 10),
            productPrice.leadingAnchor.constraint(equalTo: productImage.leadingAnchor)
        )
        
        productImage.clipsToBounds = true
        productImage.contentMode = .scaleAspectFit
        productImage.set(cornerRadius: 129)
    }
    
    
    override func setItem(item: Products) {
        productNameLabel.text = item.productName
        productPrice.text = item.productPrice
       // productImage.load(photoUrl: item.productImageUrl)
        productImage.image = item.productImage
    }
}



class ProductsFlowLayout: CollectionViewFlowLayout {
    
    
    override var margin: Int {
        10
    }
    
    
    override var numberOfColumn: Int {
        2
    }
    
    
    override var itemHeightMultiplier: Double {
        1.75
    }
    
}


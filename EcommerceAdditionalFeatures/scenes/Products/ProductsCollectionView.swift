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
    private let likeButton = Button()
    private let dislikeButton = Button()
    
    
    override func configure() {
        backgroundColor = .lightGray
        layer.cornerRadius = 10
        
        contentView.addSubview(productNameLabel)
        contentView.addSubview(productPrice)
        contentView.addSubview(productImage)
        contentView.addSubview(likeButton)
        contentView.addSubview(dislikeButton)
        
        activateConstraints(
            productImage.safeAreaLayoutGuide.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 25),
            productImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 15),
            productImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            
            productNameLabel.topAnchor.constraint(equalTo: productImage.bottomAnchor, constant: 10),
            productNameLabel.leadingAnchor.constraint(equalTo: productImage.leadingAnchor),
            
            productPrice.topAnchor.constraint(equalTo: productNameLabel.bottomAnchor, constant: 10),
            productPrice.leadingAnchor.constraint(equalTo: productImage.leadingAnchor),
            
            likeButton.safeAreaLayoutGuide.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 5),
            likeButton.bottomAnchor.constraint(equalTo: productImage.topAnchor, constant: 20),
            likeButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -35),
            
            dislikeButton.safeAreaLayoutGuide.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 5),
            dislikeButton.bottomAnchor.constraint(equalTo: productImage.topAnchor, constant: 20),
            dislikeButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        )
        
        productImage.clipsToBounds = true
        productImage.contentMode = .scaleAspectFit
        productImage.set(cornerRadius: 129)
        
        likeButton.setImage(.iconSuccess, for: .normal)
        likeButton.layer.cornerRadius = 0.8
        likeButton.action = likeButtonClicked
        
        dislikeButton.setImage(.iconWarning, for: .normal)
        dislikeButton.layer.cornerRadius = 0.8
        dislikeButton.action = dislikeButtonClicked
    }
    
    
    private func likeButtonClicked() {
        print("PRİNT: Like button is clicked")
        
        likeButton.backgroundColor = .systemGreen
        guard
            let price = productPrice.text,
            let name = productNameLabel.text
          //  let resim = productImage.image
        else {
            return
        }
    
        let product = Products(uid: nil, productName: name, productPrice: price)
         DatabaseService.instance.savePopularProducts(product: product) {
             print("PRİNT: DATABASE 'E ÜRÜN KAYDEDİLDİ.")
             DatabaseService.instance.control3 {
                 print("PRİNT: 2 KİŞİ AYNI ÜRÜNÜ BEĞENDİ BRAVO !!!!!!")
             }
         }
    }
    
    
    private func dislikeButtonClicked() {
        print("PRİNT: Dislike button is clikced")
        dislikeButton.backgroundColor = .systemRed
    }
    
    
    override func setItem(item: Products) {
        productNameLabel.text = item.productName
        productPrice.text = item.productPrice
     //   productImage.load(photoUrl: item.productImageUrl)
      //  productImage.image = item.productImage
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


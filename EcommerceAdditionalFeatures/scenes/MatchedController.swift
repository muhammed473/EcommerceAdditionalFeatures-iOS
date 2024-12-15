//
//  MatchedController.swift
//  EcommerceAdditionalFeatures
//
//  Created by muhammed dursun on 28.11.2024.
//
import UIKit



class MatchedController: Controller<MatchedViewModel, MatchedNavigationController> {
    
    var urun: String?
    let urunLabel = Label()
    let imageView = ImageView()
    
    
    init(urun: String? = nil) {
        self.urun = urun
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        addSubviews(urunLabel, imageView)
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        activateConstraints(
            urunLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            urunLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            
            imageView.topAnchor.constraint(equalTo: urunLabel.topAnchor, constant: 40),
            imageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            imageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            imageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        )
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DatabaseService.instance.matchedProductShow(urunAdi: urun!,completion: { product in
            self.urunLabel.text = product.productName
            
            let imageName = product.productName?.lowercased() ?? ""
            
            if let image = UIImage(named: imageName) {
                self.imageView.image = image
            } else {
                self.imageView.image = UIImage(named: "default_image")
            }
        })
    }
    
}

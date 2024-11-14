//
//  CollectionView.swift
//  EcommerceAdditionalFeatures
//
//  Created by muhammed dursun on 14.11.2024.
//

import UIKit


//MARK: CollectionView
private protocol Source: UICollectionViewDelegate, UICollectionViewDataSource {
    associatedtype ITEM
    
    func setItems(items: [ITEM])
    func addItem(item: ITEM)
    func addItems(newItems: [ITEM])
}


//MARK: CollectionView
class CollectionView<ITEM, C: CollectionViewCell<ITEM>, L: CollectionViewFlowLayout>: UICollectionView, Source {
    
    private let cellId = UUID().uuidString
    private var items: [ITEM] = []
    var onItemSelected: Callback<ITEM>?
    
    
    init() {
        super.init(frame: .zero, collectionViewLayout: .init())
        
        translatesAutoresizingMaskIntoConstraints = false
        register(C.self, forCellWithReuseIdentifier: cellId)
        backgroundColor = .clear
        collectionViewLayout = L()
        delegate = self
        dataSource = self
        
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure() { }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? C else {
            return .init()
        }
        
        let item = items[indexPath.item]
        cell.setItem(item: item)
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let onItemSelected = onItemSelected else {
            return
        }

        let item = items[indexPath.item]
        onItemSelected(item)
        
        //TODO: deselect
        guard let cell = cellForItem(at: indexPath) else {
            return
        }
        
        UIView.animate(withDuration: 0.2) {
            cell.alpha = 0.5
        } completion: { _ in
            UIView.animate(withDuration: 0.2) {
                cell.alpha = 1
            }
        }
    }
    
    
    ///TableView'a liste halinde eleman eklemek için kullanırız.
    func setItems(items: [ITEM]) {
        self.items = items
        reloadData()
    }
    
    
    /// Listenin sonuna eleman eklemek için kullanırız.
    func addItem(item: ITEM) {
        items.append(item)
        let indexPath = IndexPath(item: items.count - 1, section: 0)
        reloadItems(at: [indexPath])
    }
    
    
    /// Listenin sonuna elemanlar eklemek için kullanırız.
    func addItems(newItems: [ITEM]) {
        items.append(contentsOf: newItems)
        
        let startIndex = items.count - newItems.count
        
        let indexPaths: [IndexPath] = (startIndex ..< items.count).map {
            .init(item: $0, section: 0)
        }
        
        reloadItems(at: indexPaths)
    }
    
    
    ///Listeyi temizlemek için kullanırız.
    func clear() {
        items.removeAll()
        reloadData()
    }
}



//MARK: FlowLayout
class CollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    ///Hücreler arası boşluk için override edilir.
    var margin: Int {
        0
    }
    
    ///Sütun sayısı belirlemek için override edilir.
    var numberOfColumn: Int {
        0
    }
    
    ///Hücre yüksekliğinin, genişliğinin kaç katı olduğunu belirlemek için override edilir.
    var itemHeightMultiplier: Double {
        0
    }
    
    
    
    required override init() {
        super.init()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func prepare() {
        guard let collectionView = collectionView else {
            return
        }
        
        let margin = CGFloat(margin)
        let numberOfColumn = CGFloat(numberOfColumn)
        let itemHeightMultiplier = CGFloat(itemHeightMultiplier)
        
        let itemWidth = (collectionView.frame.width - (numberOfColumn + 1) * margin) / numberOfColumn

        sectionInset = .init(top: margin, left: margin, bottom: margin, right: margin)
        itemSize = .init(width: itemWidth, height: itemWidth * itemHeightMultiplier)
        minimumLineSpacing = margin
        minimumInteritemSpacing = margin
    }
}




//MARK: CollectionViewCell
class CollectionViewCell<ITEM>: UICollectionViewCell {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure() { }
    
    
    func setItem(item: ITEM) { }
    
    
    func activateConstraints(_ constraints: NSLayoutConstraint...) {
        NSLayoutConstraint.activate(constraints)
    }
}


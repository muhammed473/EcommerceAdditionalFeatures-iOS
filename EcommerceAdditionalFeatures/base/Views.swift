//
//  Views.swift
//  EcommerceAdditionalFeatures
//
//  Created by muhammed dursun on 9.11.2024.
//

import UIKit

// MARK: Label
class Label: UILabel {
    
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure() { }
}



// MARK: Button
class Button: UIButton {
    
    var action: Handler?
    
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        addTarget(self, action: #selector(clicked), for: .touchUpInside)
        
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override var isHighlighted: Bool {
        didSet {
            alpha = isHighlighted ? 0.5 : 1
        }
    }
    
    
    func configure() { }
    
    
    @objc private func clicked() {
        action?()
    }
}



// MARK: TextField
class TextField: UITextField {
    
    private let padding = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    
    
    init() {
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure() { }
    
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
    
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
}



//MARK: View
class View: UIView {
    
    init() {
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure() { }
}



//MARK: UserInteractionView
class UserInteractionView: View {
    
    private let background = View()
    
    
    override func configure() {
        background.backgroundColor = .blue
        background.alpha = 0.5
        
        addSubview(background)
        
        NSLayoutConstraint.activate([
            background.leadingAnchor.constraint(equalTo: leadingAnchor),
            background.trailingAnchor.constraint(equalTo: trailingAnchor),
            background.topAnchor.constraint(equalTo: topAnchor),
            background.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    
    func setup(window: UIWindow) {
        alpha = 0
        window.addSubview(self)
        
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: window.leadingAnchor),
            trailingAnchor.constraint(equalTo: window.trailingAnchor),
            bottomAnchor.constraint(equalTo: window.bottomAnchor),
            topAnchor.constraint(equalTo: window.topAnchor),
        ])
    }
    
    
    func show() {
        superview?.bringSubviewToFront(self)
        UIView.animate(withDuration: 0.3, animations: animate, completion: afterShow)
        
        func animate() {
            alpha = 1
        }
    }
    
    
    @objc func hide() {
        guard alpha == 1 else { return }
        
        UIView.animate(withDuration: 0.3, animations: animate, completion: afterHide)
        
        func animate() {
            alpha = 0
        }
    }
    
    
    func afterShow(_: Bool) {
        
    }
    
    
    func afterHide(_: Bool) {
        
    }
    
    
    var isCancelable: Bool {
        get {
            background.isUserInteractionEnabled
        }
        
        set {
            background.isUserInteractionEnabled = newValue
            
            background.gestureRecognizers = [
                UITapGestureRecognizer(target: self, action: #selector(hide))
            ]
        }
    }
}



//MARK: ImageView
class ImageView: UIImageView {
    
    init() {
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure() { }
    
    
    func set(cornerRadius: CGFloat) {
        layer.cornerRadius = cornerRadius
        
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: cornerRadius * 2),
            heightAnchor.constraint(equalToConstant: cornerRadius * 2)
        ])
    }
}


//MARK: StackView
class StackView: UIStackView {
    
    
    init() {
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        configure()
    }
    
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure() { }
}


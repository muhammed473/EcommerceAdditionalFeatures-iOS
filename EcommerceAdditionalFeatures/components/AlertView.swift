//
//  AlertView.swift
//  EcommerceAdditionalFeatures
//
//  Created by muhammed dursun on 9.11.2024.
//

import UIKit


class AlertView: UserInteractionView {
    
    static let instance = AlertView()
    private let icon = ImageView()
    private let container = View()
    private let labelTitle = Label()
    private let labelMessage = Label()
    private let buttonStack = StackView()
    
    
    override func configure() {
        super.configure()
        
        buttonStack.distribution = .fillEqually
        buttonStack.spacing = 5
        
        labelTitle.textAlignment = .center
        labelTitle.font = .setDynamicFont(size: 18)
        labelTitle.textColor = .black
        
        labelMessage.textAlignment = .center
        labelMessage.font = .setDynamicFont(size: 16)
        labelMessage.textColor = .black.withAlphaComponent(0.5)
        labelMessage.numberOfLines = 0
        
        container.layer.cornerRadius = 20
        container.layer.borderWidth = 1
        container.layer.borderColor = UIColor.white.withAlphaComponent(0.5).cgColor
        container.backgroundColor = .white
        
        icon.contentMode = .scaleAspectFit
        
        container.addSubview(labelTitle)
        container.addSubview(labelMessage)
        container.addSubview(buttonStack)
        container.addSubview(icon)
        
        addSubview(container)
        
        NSLayoutConstraint.activate([
            icon.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 5),
            icon.topAnchor.constraint(equalTo: container.topAnchor, constant: 5),
            icon.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.1),
            icon.heightAnchor.constraint(equalTo: icon.widthAnchor),
            
            labelTitle.centerYAnchor.constraint(equalTo: icon.centerYAnchor),
            labelTitle.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 10),
            labelTitle.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -10),
            
            labelMessage.topAnchor.constraint(equalTo: labelTitle.bottomAnchor, constant: 20),
            labelMessage.leadingAnchor.constraint(equalTo: labelTitle.leadingAnchor),
            labelMessage.trailingAnchor.constraint(equalTo: labelTitle.trailingAnchor),
            
            buttonStack.topAnchor.constraint(equalTo: labelMessage.bottomAnchor, constant: 10),
            buttonStack.leadingAnchor.constraint(equalTo: labelMessage.leadingAnchor),
            buttonStack.trailingAnchor.constraint(equalTo: labelMessage.trailingAnchor),
            
            container.centerXAnchor.constraint(equalTo: centerXAnchor),
            container.centerYAnchor.constraint(equalTo: centerYAnchor),
            container.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
            container.bottomAnchor.constraint(equalTo: buttonStack.bottomAnchor, constant: 10)
        ])
    }
    
    
    func show(type: AlertType, title: String? = nil, message: String?, isCancelable: Bool = false, actions: [AlertModel]) {
        LoadingView.instance.hide()
        
        labelTitle.text = title ?? type.title
        labelMessage.text = message
        
        icon.image = type.icon
        icon.tintColor = type.tintColor
        
        self.isCancelable = isCancelable
        
        for button in buttonStack.arrangedSubviews {
            button.removeFromSuperview()
        }
        
        for item in actions {
            let button = ButtonTitle()
            button.titleLabel?.font = .setDynamicFont(size: 16)
            button.setTitle(item.title, for: .normal)
            button.setTitleColor(.black, for: .normal)
            
            button.action = {
                item.action?()
                self.hide()
            }
            
            buttonStack.addArrangedSubview(button)
        }
        
        super.show()
    }
}

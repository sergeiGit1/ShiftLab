//
//  UIComponentFactory.swift
//  ShiftLab
//
//  Created by Сергей Дашко on 10.12.2023.
//

import UIKit

class UIComponentFactory {
    static let shared = UIComponentFactory()
    
    private init () {}
    
    func makeLabel(withText text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }

    func makeTextField(withPlaceholder placeholder: String, target: Any?, action: Selector?) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeholder
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        if let action = action {
            textField.addTarget(target, action: action, for: .editingChanged)
        }
        
        return textField
    }

    func makeButton(withTitle title: String, target: Any?, action: Selector?) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16.0)
        button.layer.cornerRadius = 20
        button.backgroundColor = .systemBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        
        if let action = action {
            button.addTarget(target, action: action, for: .touchUpInside)
        }
        
        return button
    }
    
    func makeAlert(title: String, message: String) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        return alertController
    }
}

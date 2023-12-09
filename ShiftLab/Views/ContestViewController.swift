//
//  ContestViewController.swift
//  ShiftLab
//
//  Created by Сергей Дашко on 10.12.2023.
//

import UIKit

class ContestViewController: UIViewController {
    
    // MARK: - Properties
    
    private let uiComponentFactory = UIComponentFactory.shared
    private let userDataStore: UserDataStoreProtocol = UserDataStore()
    
    // MARK: - UI Elements
    
    private lazy var greetingsButton = uiComponentFactory.makeButton(withTitle: "Приветсвие",
                                                                     target: self,
                                                                     action: #selector(greetingsAction))
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - UI Setup
    
    func setupUI() {
        view.addSubview(greetingsButton)
        view.backgroundColor = .white
        
        NSLayoutConstraint.activate([
            greetingsButton.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -200),
            greetingsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            greetingsButton.widthAnchor.constraint(equalToConstant: 250),
            greetingsButton.heightAnchor.constraint(equalToConstant: 44),
        ])
    }

    @objc func greetingsAction() {
        if let user = userDataStore.loadUserData(), let userName = user.name {
            let alertController = UIAlertController(title: "Привет! ", message: "\(userName)", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alertController, animated: true, completion: nil)
        } else {
            let alertController = UIAlertController(title: "Упс...", message: "Данные пользователя не найдены.", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alertController, animated: true, completion: nil)
        }
    }

}

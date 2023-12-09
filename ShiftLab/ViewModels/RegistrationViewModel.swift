//
//  RegistrationViewModel.swift
//  ShiftLab
//
//  Created by Сергей Дашко on 09.12.2023.
//

import Foundation
import UIKit

class RegistrationViewModel {
    private let userDataStore: UserDataStoreProtocol
    var isRegistrationSuccessful: Bool = false
    var registrationCompletion: (() -> Void)?
    var statusText = Dynamic("")
    
    init(userDataStore: UserDataStoreProtocol = UserDataStore()) {
        self.userDataStore = userDataStore
    }

    func invalidName(_ name: String) -> Bool {
        return name.contains { $0.isNumber } || name.count <= 1
    }

    func validatePassword(_ password: String) -> Bool {
        let passwordRegex = "^[А-Яа-яA-Za-z0-9]{6,}$"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: password)
    }

    func userButtonPressed(name: String, surname: String, date: String, password: String, secondPassword: String) {
        if invalidName(name) {
            statusText.value = ("Имя не может содержать цифр и должно состоять из более чем одной буквы")
        } else if invalidName(surname) {
            statusText.value = ("Фамилия не может содержать цифр и должна состоять из более чем одной буквы")
        } else if !validatePassword(password) {
            statusText.value = ("Пароль должен быть не менее 6 символов в длину")
        } else if password != secondPassword {
            statusText.value = ("Пароли не совпадают")
        } else {
            statusText.value = ""
            isRegistrationSuccessful = true
            
            let user = UserData(name: name, surname: surname, dateOfBirth: date, password: password)
            userDataStore.saveUserData(user: user)
            
            if isRegistrationSuccessful {
                registrationCompletion?()
            }
        }
    }
}

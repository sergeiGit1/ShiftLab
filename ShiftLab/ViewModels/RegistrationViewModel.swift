//
//  RegistrationViewModel.swift
//  ShiftLab
//
//  Created by Сергей Дашко on 09.12.2023.
//

import Foundation

class RegistrationViewModel {
    private let userDataStore: UserDataStoreProtocol
    var isRegistrationSuccessful: Bool = false
    var registrationCompletion: (() -> Void)?
    var statusText = Dynamic("")

    init(userDataStore: UserDataStoreProtocol = UserDataStore()) {
        self.userDataStore = userDataStore
    }

    func invalidNumberName(_ name: String) -> Bool {
        return name.contains { $0.isNumber }
    }

    func invalidShortName(_ name: String) -> Bool {
        return name.count <= 1
    }

    func validatePasswordLength(_ password: String) -> Bool {
        let passwordRegex = "^[А-Яа-яA-Za-z0-9]{6,}$"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: password)
    }

    func validateUppercaseLetter(_ password: String) -> Bool {
        let uppercaseLetterRegex = ".*[A-ZА-Я]+.*"
        return NSPredicate(format: "SELF MATCHES %@", uppercaseLetterRegex).evaluate(with: password)
    }
    
    private func isNameValid(_ name: String) -> Bool {
        if invalidNumberName(name) {
            statusText.value = "Ошибка: Имя не может содержать цифры"
            return false
        } else if invalidShortName(name) {
            statusText.value = "Ошибка: Имя слишком короткое. Оно должно состоять из более чем одной буквы"
            return false
        }
        return true
    }

    private func isSurnameValid(_ surname: String) -> Bool {
        if invalidNumberName(surname) {
            statusText.value = "Ошибка: Фамилия не может содержать цифры"
            return false
        } else if invalidShortName(surname) {
            statusText.value = "Ошибка: Фамилия слишком короткая. Она должна состоять из более чем одной буквы"
            return false
        }
        return true
    }

    private func isPasswordValid(_ password: String, secondPassword: String) -> Bool {
        if !validatePasswordLength(password) {
            statusText.value = "Ошибка: Пароль должен быть не менее 6 символов в длину"
            return false
        } else if !validateUppercaseLetter(password) {
            statusText.value = "Ошибка: Пароль должен содержать хотя бы одну заглавную букву"
            return false
        } else if password != secondPassword {
            statusText.value = "Ошибка: Пароли не совпадают"
            return false
        }
        return true
    }

    func userButtonPressed(name: String, surname: String, date: String, password: String, secondPassword: String) {
        guard isNameValid(name), isSurnameValid(surname), isPasswordValid(password, secondPassword: secondPassword) else {
            return
        }

        statusText.value = ""
        isRegistrationSuccessful = true
        
        let user = UserData(name: name, surname: surname, dateOfBirth: date, password: password)
        userDataStore.saveUserData(user: user)
        
        if isRegistrationSuccessful {
            registrationCompletion?()
        }
    }

}


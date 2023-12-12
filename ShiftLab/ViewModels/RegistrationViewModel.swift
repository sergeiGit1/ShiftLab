//
//  RegistrationViewModel.swift
//  ShiftLab
//
//  Created by Сергей Дашко on 09.12.2023.
//

import Foundation
import Combine

class RegistrationViewModel {
    private let userDataStore: UserDataStoreProtocol
    private let validator: RegistrationValidator
    @Published var statusText: String = ""
    @Published var isRegistrationSuccessful: Bool = false
    
    var registrationCompletion: (() -> Void)?
    
    private var cancellables = Set<AnyCancellable>()

    init(userDataStore: UserDataStoreProtocol = UserDataStore(), validator: RegistrationValidator = RegistrationValidator()) {
        self.userDataStore = userDataStore
        self.validator = validator
    }

    func userButtonPressed(name: String, surname: String, date: String, password: String, secondPassword: String) {
        guard isNameValid(name), isSurnameValid(surname), isPasswordValid(password, secondPassword: secondPassword) else {
            return
        }

        statusText = ""
        isRegistrationSuccessful = true
        
        let user = UserData(name: name, surname: surname, dateOfBirth: date, password: password)
        userDataStore.saveUserData(user: user)
        
        if isRegistrationSuccessful {
            Just(())
                .sink { [weak self] in
                    self?.registrationCompletion?()
                }
                .store(in: &cancellables)
        }
    }

    private func isNameValid(_ name: String) -> Bool {
        if validator.invalidNumberName(name) {
            statusText = RegistrationError.numberInName.rawValue
            return false
        } else if validator.invalidShortName(name) {
            statusText = RegistrationError.shortName.rawValue
            return false
        }
        return true
    }

    private func isSurnameValid(_ surname: String) -> Bool {
        if validator.invalidNumberName(surname) {
            statusText = RegistrationError.numberInSurname.rawValue
            return false
        } else if validator.invalidShortName(surname) {
            statusText = RegistrationError.shortSurname.rawValue
            return false
        }
        return true
    }

    private func isPasswordValid(_ password: String, secondPassword: String) -> Bool {
        if !validator.validatePasswordLength(password) {
            statusText = RegistrationError.passwordTooShort.rawValue
            return false
        } else if !validator.validateUppercaseLetter(password) {
            statusText = RegistrationError.passwordNeedsUppercase.rawValue
            return false
        } else if password != secondPassword {
            statusText = RegistrationError.passwordsNotMatching.rawValue
            return false
        }
        return true
    }
}

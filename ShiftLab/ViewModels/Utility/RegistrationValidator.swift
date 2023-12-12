//
//  RegistrationValidator.swift
//  ShiftLab
//
//  Created by Сергей Дашко on 12.12.2023.
//

import Foundation

enum RegistrationError: String {
    case numberInName = "Ошибка: Имя не может содержать цифры"
    case shortName = "Ошибка: Имя слишком короткое. Оно должно состоять из более чем одной буквы"
    case numberInSurname = "Ошибка: Фамилия не может содержать цифры"
    case shortSurname = "Ошибка: Фамилия слишком короткая. Она должна состоять из более чем одной буквы"
    case passwordTooShort = "Ошибка: Пароль должен быть не менее 6 символов в длину"
    case passwordNeedsUppercase = "Ошибка: Пароль должен содержать хотя бы одну заглавную букву"
    case passwordsNotMatching = "Ошибка: Пароли не совпадают"
}

struct RegistrationValidator {
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
}

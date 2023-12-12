//
//  RegistrationViewModelTests.swift
//  ShiftLabTests
//
//  Created by Сергей Дашко on 12.12.2023.
//

import XCTest
@testable import ShiftLab

class RegistrationViewModelTests: XCTestCase {
    var viewModel: RegistrationViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = RegistrationViewModel()
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func testInvalidNumberName() {
        viewModel.userButtonPressed(name: "Bar1", surname: "ValidSurname", date: "01.01.2000", password: "Password123", secondPassword: "Password123")
        XCTAssertEqual(viewModel.statusText, RegistrationError.numberInName.rawValue, "Статус текст должен сообщать об ошибке в имени")
        
        viewModel.userButtonPressed(name: "Baz", surname: "ValidSurname", date: "01.01.2000", password: "Password123", secondPassword: "Password123")
        XCTAssertNotEqual(viewModel.statusText, RegistrationError.numberInName.rawValue, "Статус текст не должен сообщать об ошибке в валидном имени")
    }
    
    func testInvalidSurnameName() {
        viewModel.userButtonPressed(name: "ValidName", surname: "Baz1", date: "01.01.2000", password: "Password123", secondPassword: "Password123")
        XCTAssertEqual(viewModel.statusText, RegistrationError.numberInSurname.rawValue, "Статус текст должен сообщать об ошибке в фамилии")
        
        viewModel.userButtonPressed(name: "ValidName", surname: "Baz", date: "01.01.2000", password: "Password123", secondPassword: "Password123")
        XCTAssertNotEqual(viewModel.statusText, RegistrationError.numberInSurname.rawValue, "Статус текст не должен сообщать об ошибке в валидной фамилии")
    }
    
    func testPasswordValidation() {
        viewModel.userButtonPressed(name: "ValidName", surname: "ValidSurname", date: "01.01.2000", password: "12345", secondPassword: "12345")
        XCTAssertEqual(viewModel.statusText, RegistrationError.passwordTooShort.rawValue, "Статус текст должен сообщать о слишком коротком пароле")
        
        viewModel.userButtonPressed(name: "ValidName", surname: "ValidSurname", date: "01.01.2000", password: "password", secondPassword: "password")
        XCTAssertEqual(viewModel.statusText, RegistrationError.passwordNeedsUppercase.rawValue, "Статус текст должен сообщать о необходимости заглавной буквы в пароле")
        
        viewModel.userButtonPressed(name: "ValidName", surname: "ValidSurname", date: "01.01.2000", password: "Password", secondPassword: "Different")
        XCTAssertEqual(viewModel.statusText, RegistrationError.passwordsNotMatching.rawValue, "Статус текст должен сообщать о несовпадении паролей")
    }
}

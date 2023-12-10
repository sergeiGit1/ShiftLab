//
//  ShiftLabTests.swift
//  ShiftLabTests
//
//  Created by Сергей Дашко on 09.12.2023.
//

import XCTest
@testable import ShiftLab

final class ShiftLabTests: XCTestCase {

    var viewModel: RegistrationViewModel!

    override func setUp() {
        super.setUp()
        viewModel = RegistrationViewModel()
    }

    func testInvalidName() {
        XCTAssertTrue(viewModel.invalidShortName("B"))
        XCTAssertTrue(viewModel.invalidNumberName("123"))
    }
    
    func testValidName() {
        XCTAssertFalse(viewModel.invalidNumberName("Bar"))
        XCTAssertFalse(viewModel.invalidShortName("Baz"))
    }

    func testInvalidPassword() {
        XCTAssertFalse(viewModel.validatePasswordLength("bazba"))
        XCTAssertFalse(viewModel.validateUppercaseLetter("bazbar"))
    }

    func testValidPassword() {
        XCTAssertTrue(viewModel.validatePasswordLength("bazbar"))
        XCTAssertTrue(viewModel.validateUppercaseLetter("Bazbar"))
    }

    func testMatchingPasswords() {
        viewModel.userButtonPressed(name: "John", surname: "Doe", date: "01-01-2000", password: "Password", secondPassword: "Password")
        XCTAssertTrue(viewModel.isRegistrationSuccessful)
    }

    func testNonMatchingPasswords() {
        viewModel.userButtonPressed(name: "John", surname: "Doe", date: "01-01-2000", password: "Password", secondPassword: "DifferentPassword")
        XCTAssertFalse(viewModel.isRegistrationSuccessful)
    }

    func testEmptyStatusText() {
        viewModel.userButtonPressed(name: "John", surname: "Doe", date: "01-01-2000", password: "Password", secondPassword: "Password")
        XCTAssertEqual(viewModel.statusText.value, "")
    }

    func testStatusTextError() {
        viewModel.userButtonPressed(name: "123", surname: "Doe", date: "01-01-2000", password: "Password", secondPassword: "Password")
        XCTAssertNotEqual(viewModel.statusText.value, "")
    }
}


//
//  ShiftLabTests.swift
//  ShiftLabTests
//
//  Created by Сергей Дашко on 09.12.2023.
//

import XCTest
@testable import ShiftLab

final class ShiftLabTests: XCTestCase {

    var sut: RegistrationViewModel!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = RegistrationViewModel()
    }
    
    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func testInvalidName() {
        XCTAssertTrue(sut.invalidShortName("B") == true)
        XCTAssertTrue(sut.invalidNumberName("123"))
    }
    
    func testValidName() {
        XCTAssertFalse(sut.invalidNumberName("Bar"))
        XCTAssertFalse(sut.invalidShortName("Baz"))
    }

    func testInvalidPassword() {
        XCTAssertFalse(sut.validatePasswordLength("bazba"))
        XCTAssertFalse(sut.validateUppercaseLetter("bazbar"))
    }

    func testValidPassword() {
        XCTAssertTrue(sut.validatePasswordLength("bazbar"))
        XCTAssertTrue(sut.validateUppercaseLetter("Bazbar"))
    }

    func testMatchingPasswords() {
        sut.userButtonPressed(name: "Baz", surname: "Bar", date: "01-01-2000", password: "Password", secondPassword: "Password")
        XCTAssertTrue(sut.isRegistrationSuccessful)
    }

    func testNonMatchingPasswords() {
        sut.userButtonPressed(name: "Baz", surname: "Bar", date: "01-01-2000", password: "Password", secondPassword: "DifferentPassword")
        XCTAssertFalse(sut.isRegistrationSuccessful)
    }

    func testEmptyStatusText() {
        sut.userButtonPressed(name: "Baz", surname: "Bar", date: "01-01-2000", password: "Password", secondPassword: "Password")
        XCTAssertEqual(sut.statusText.value, "")
    }

    func testStatusTextError() {
        sut.userButtonPressed(name: "123", surname: "Bar", date: "01-01-2000", password: "Password", secondPassword: "Password")
        XCTAssertNotEqual(sut.statusText.value, "")
    }
}


//
//  LoginScreenTest.swift
//  iOSFinalProjectTests
//
//  Created by Trainee on 1/3/25.
//

@testable import iOSFinalProject
import XCTest

final class LoginScreenTest: XCTestCase {
    
    var logInViewModel: LogInViewModel!
    
    override func setUp() {
        super.setUp()
        logInViewModel = LogInViewModel()
    }
    
    override func tearDown() {
        logInViewModel = nil
        super.tearDown()
    }
    
    func testEmptyCredentialsShowErrorMessage() {
        // Given: Empty credentials
        logInViewModel.username = ""
        logInViewModel.password = ""
        
        // When
        logInViewModel.SignIn()
        
        // Then
        XCTAssertEqual(logInViewModel.errorMessage, StringsConstantsValue.noUserNameOrPassword.rawValue)
        XCTAssertFalse(logInViewModel.isLoggedIn)
        XCTAssertTrue(logInViewModel.showError)
    }
    
    func testCorrectCredentialsShowSuccessMessage() {
        // Given: Correct credentials
        logInViewModel.username = "test@example.com"
        logInViewModel.password = "12345678"
        
        // When
        logInViewModel.SignIn()
        
        // Then
        XCTAssertTrue(logInViewModel.isLoggedIn)
        XCTAssertEqual(logInViewModel.successMessage, StringsConstantsValue.successfulLogin.rawValue)
        XCTAssertFalse(logInViewModel.showError)
    }
    
    func testWrongUserShowInvalidUserMessage()  {
        // Given: Correct credentials
        logInViewModel.username = "john5com@example.com"
        logInViewModel.password = "johnps78"
        
        // When
        logInViewModel.SignIn()
        
        // Then
        XCTAssertEqual(logInViewModel.errorMessage, StringsConstantsValue.invalidUserName.rawValue)
        XCTAssertFalse(logInViewModel.isLoggedIn)
        XCTAssertTrue(logInViewModel.showError)
    }
}

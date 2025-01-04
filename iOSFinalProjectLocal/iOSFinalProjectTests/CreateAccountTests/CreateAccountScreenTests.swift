//
//  iOSFinalProjectTests.swift
//  iOSFinalProjectTests
//
//  Created by Trainee on 12/31/24.
//

import XCTest
@testable import iOSFinalProject

final class CreateAccountScreenTests: XCTestCase {
    
    private var createAccountViewModel: CreateAccountViewModel!

    override func setUpWithError() throws {
        try super.setUpWithError()
        createAccountViewModel = CreateAccountViewModel()
    }

    override func tearDownWithError() throws {
        createAccountViewModel = nil
        try super.tearDownWithError()
    }
    
    func test_ifUsernameIsValid_validationStatusIsNone(){
        // Given
        let expectedStatus = ValidationError.none
        createAccountViewModel.name = "test"
        
        // When
        createAccountViewModel.validateUsername()
        let status = createAccountViewModel.validationStatus
        
        // Then
        XCTAssertEqual(status, expectedStatus)
    }
    
    func test_ifUsernameIsToShort_validationStatusIsInvalidUsername(){
        // Given
        let expectedStatus = ValidationError.invalidUsername
        createAccountViewModel.name = "te"
        
        // When
        createAccountViewModel.validateUsername()
        let status = createAccountViewModel.validationStatus
        
        // Then
        XCTAssertEqual(status, expectedStatus)
    }
    
    func test_ifEmailDoesntContainAnAt_validationStatusIsMissingAtEmail(){
        // Given
        let expectedStatus = ValidationError.missingAtEmail
        createAccountViewModel.email = "testEmail.com"
        
        // When
        createAccountViewModel.validateEmail()
        let status = createAccountViewModel.validationStatus
        
        // Then
        XCTAssertEqual(status, expectedStatus)
    }
    
    func test_ifEmailDoesntContainADomain_validationStatusIsMissingEmailDomain(){
        // Given
        let expectedStatus = ValidationError.missingEmailDomain
        createAccountViewModel.email = "testEmail@gmail"
        
        // When
        createAccountViewModel.validateEmail()
        let status = createAccountViewModel.validationStatus
        
        // Then
        XCTAssertEqual(status, expectedStatus)
    }
    
    func test_ifEmailIsInvalid_validationStatusIsInvalidEmail(){
        // Given
        let expectedStatus = ValidationError.invalidEmail
        createAccountViewModel.email = "t.est@InvalidEmail"
        
        // When
        createAccountViewModel.validateEmail()
        let status = createAccountViewModel.validationStatus
        
        // Then
        XCTAssertEqual(status, expectedStatus)
    }
    
    func test_ifEmailisValid_validationStatusIsNone(){
        // Given
        let expectedStatus = ValidationError.none
        createAccountViewModel.email = "test@Email.com"
        
        // When
        createAccountViewModel.validateEmail()
        let status = createAccountViewModel.validationStatus
        
        // Then
        XCTAssertEqual(status, expectedStatus)
    }
    
    func test_ifPasswordIsInvalid_validationStatusIsInvalidPassword(){
        // Given
        let expectedStatus = ValidationError.invalidPassword
        createAccountViewModel.password = "testPassword"
        
        // When
        createAccountViewModel.validatePassword()
        let status = createAccountViewModel.validationStatus
        
        // Then
        XCTAssertEqual(status, expectedStatus)
    }
    
    func test_ifPasswordIsValid_validationStatusIsNone(){
        // Given
        let expectedStatus = ValidationError.none
        createAccountViewModel.password = "TestPassword1!"
        
        // When
        createAccountViewModel.validatePassword()
        let status = createAccountViewModel.validationStatus
        
        // Then
        XCTAssertEqual(status, expectedStatus)
    }
    
    func test_ifAllFieldsAreCorrect_validateInfoIsTrue(){
        // Given
        let expectedValidation = true
        createAccountViewModel.name = "TestUsername"
        createAccountViewModel.email = "test@Email.com"
        createAccountViewModel.password = "TestPassword1!"
        
        // When
        let validation =  createAccountViewModel.validateInfo()
        
        // Then
        XCTAssertEqual(validation, expectedValidation)
    }
    
    

}

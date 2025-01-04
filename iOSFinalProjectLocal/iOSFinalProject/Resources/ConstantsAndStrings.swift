//
//  ConstantsAndStrings.swift
//  iOSFinalProject
//
//  Created by Trainee on 1/2/25.
//

import Foundation

enum ValidationError: String {
    case invalidUsername = "Username must have at least 3 characters"
    case invalidPassword = "Password must have at least 8 characters, uppercase and lowercase letters, at least one number and a special character e.g. 'SecurePassword23!'"
    case invalidEmail = "Invalid Email. Please enter a valid email address e.g. 'email@example.com'"
    case missingAtEmail = "Email should contain an '@'"
    case missingEmailDomain = "Email should contain a domain e.g. '.com'"
    case none = ""
}

enum CreateAccountStrings: String {
    case title = "Create Account"
    case nameLabel = "Name"
    case usernamePlaceHolder = "Username"
    case emailLabel = "Email"
    case emailPlaceHolder = "example@gmail.com"
    case passwordLabel = "Password"
    case passwordPlaceHolder = "Secure Password"
}
enum Constants: Int {
    case minimumUsernameInputLength = 3
}

enum FontSizes: CGFloat {
    case errorMessageLabelSize = 12
}

enum StringsConstantsValue: String {
    case noUserNameOrPassword = "Please enter username and password."
    case username = "test@example.com"
    case password = "12345678"
    case invalidUserName = "Invalid Username or Password."
    case successfulLogin = "Login successful!"
}

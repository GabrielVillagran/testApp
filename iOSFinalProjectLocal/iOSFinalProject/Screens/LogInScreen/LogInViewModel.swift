//
//  LogInViewModel.swift
//  SwiftUIandUIKit
//
//  Created by GenericDevCalifornia on 12/30/24.
//
import Combine
import Foundation
import SwiftUI

class LogInViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var isLoggedIn: Bool = false
    @Published var showError: Bool = false
    @Published var navigateToCreateAccount: Bool = false
    var errorMessage: String = ""
    var successMessage: String = ""
    
    func SignIn() {
           if username.isEmpty || password.isEmpty {
               errorMessage = StringsConstantsValue.noUserNameOrPassword.rawValue
               isLoggedIn = false
               showError = true
           } else if username == "test@example.com" && password == "12345678" {
               isLoggedIn = true
               successMessage = StringsConstantsValue.successfulLogin.rawValue
               showError = false
               errorMessage = ""
           } else {
               errorMessage = StringsConstantsValue.invalidUserName.rawValue
               isLoggedIn = false
               showError = true
           }
       }
    
    func forgotPassword() {
        // TODO: To be implemented later
    }
    
    func becomeMember() {
        navigateToCreateAccount = true
    }
}

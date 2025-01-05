//
//  LogInViewModel.swift
//  SwiftUIandUIKit
//
//  Created by GenericDevCalifornia on 12/30/24.

import Combine
import Foundation
import SwiftUI

class LogInViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isLoggedIn: Bool = false
    @Published var showError: Bool = false
    @Published var navigateToCreateAccount: Bool = false
    @StateObject private var viewModel = LogInViewModel()

    var errorMessage: String = ""
    var successMessage: String = ""
    
    func SignIn() {
        let savedEMail = UserDefaults.standard.string(forKey: "email") ?? ""
        let savedPassword = UserDefaults.standard.string(forKey: "password") ?? ""

           if email.isEmpty || password.isEmpty {
               errorMessage = StringsConstantsValue.noUserNameOrPassword.rawValue
               isLoggedIn = false
               showError = true
           } else if email == savedEMail && password == savedPassword {
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

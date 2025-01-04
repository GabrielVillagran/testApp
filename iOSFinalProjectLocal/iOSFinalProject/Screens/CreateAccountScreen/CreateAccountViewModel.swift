//
//  CreateUserViewModel.swift
//  TrainingFinalProject
//
//  Created by Trainee on 12/30/24.
//

import Foundation
import SwiftUI

class CreateAccountViewModel: ObservableObject {

    @Published var name: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var validationStatus: ValidationError = .none

    func validateUsername() {
        if !isValidUsername(name) && !name.isEmpty {
            validationStatus = .invalidUsername
        } else {
            validationStatus = .none
        }
    }
    
    func validatePassword() {
        if !isValidPassword(password) && !password.isEmpty {
            validationStatus = .invalidPassword
        } else {
            validationStatus = .none
        }
    }
    
    func validateEmail() {
        if !email.contains("@") && !email.isEmpty {
            validationStatus = .missingAtEmail
        }
        else if !email.contains(".") && !email.isEmpty {
            validationStatus = .missingEmailDomain
        }
        
        else if !isValidEmail(email) && !email.isEmpty {
            validationStatus = .invalidEmail
        }
        else {
            validationStatus = .none
        }
    }
    
    func validateInfo() -> Bool {
        return isValidUsername(name) && isValidEmail(email) && isValidPassword(password)
    }
}

private extension CreateAccountViewModel {
    
    func isValidUsername(_ name: String) -> Bool{
        if name.count < Constants.minimumUsernameInputLength.rawValue {
            return false
        }
        return true
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}")
        return emailPredicate.evaluate(with: email)
    }

    func isValidPassword(_ password: String) -> Bool {
        let passwordFormat = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[$@$!%*#?&])[A-Za-z\\d$@$!%*#?&]{8,}$"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordFormat)
        return passwordPredicate.evaluate(with: password)
    }
}

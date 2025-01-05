//
//  RootViewModel.swift
//  inClass-SwiftUI
//
//  Created by David Castaneda on 10/25/23.
//

import Foundation

class RootViewModel: ObservableObject {
    
    @Published var currentScreen: RootDestinations = .auth
}

extension RootViewModel: UserSessionListener {
    func onSignIn() {
        currentScreen = .createAccount
    }
    
    func onSignOut() {
        currentScreen = .auth
    }
}

protocol UserSessionListener {
    func onSignIn()
    func onSignOut()
}

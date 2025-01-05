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

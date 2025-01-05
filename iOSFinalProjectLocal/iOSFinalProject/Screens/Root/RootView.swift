
import SwiftUI

struct RootView: View {
    
    @ObservedObject
    private var viewModel: RootViewModel
    
    init(viewModel: RootViewModel = DependencyInitializer.container.resolve(RootViewModel.self)!) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        Group {
            switch viewModel.currentScreen {
                case .auth: LoginView()
            case .createAccount: CreateAccountView()
            }
        }
    }
}

#Preview {
    RootView()
}

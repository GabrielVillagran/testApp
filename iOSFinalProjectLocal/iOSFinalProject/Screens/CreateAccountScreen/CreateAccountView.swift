import Foundation
import SwiftUI

struct CreateAccountView: View {
    @ObservedObject private var viewModel: CreateAccountViewModel

    init(viewModel: CreateAccountViewModel = DependencyInitializer.container.resolve(CreateAccountViewModel.self)!) {
        self.viewModel = viewModel
    }

    var body: some View {
        NavigationView {
            VStack {
                Text(CreateAccountStrings.title.rawValue)
                    .font(.title)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .center)
                
                LabelAndTextField(title: CreateAccountStrings.nameLabel.rawValue, inputPlaceHolder: CreateAccountStrings.usernamePlaceHolder.rawValue, inputBinder: $viewModel.name)
                    .onChange(of: viewModel.name) {
                        viewModel.validateUsername()
                    }
                
                LabelAndTextField(title: CreateAccountStrings.emailLabel.rawValue, inputPlaceHolder: CreateAccountStrings.emailPlaceHolder.rawValue, inputBinder: $viewModel.email)
                    .onChange(of: viewModel.email) {
                        viewModel.validateEmail()
                    }
                
                LabelAndTextField(title: CreateAccountStrings.passwordLabel.rawValue, inputPlaceHolder: CreateAccountStrings.passwordPlaceHolder.rawValue, inputBinder: $viewModel.password)
                    .onChange(of: viewModel.password) {
                        viewModel.validatePassword()
                    }
                ErrorLabel(message: viewModel.validationStatus.rawValue)
                
                Spacer()
                Button(CreateAccountStrings.title.rawValue)
                {
                    if viewModel.validateAccount() {
                        viewModel.showError = true
                    } else {
                        viewModel.saveUserInformation()
                        viewModel.accountCreated = true
                        viewModel.navigateToLogin = true
                    }
                }
                .disabled(!viewModel.validateInfo())
                .alert(isPresented: $viewModel.accountCreated) {
                    Alert(
                        title: Text("Account Created"),
                        message: Text("Your account has been created succesfully."),
                        dismissButton: .default(Text("OK")) {
                            viewModel.navigateToLogin = true
                        }
                    )
                }
                NavigationLink(
                    destination: LoginView(),
                    isActive: $viewModel.navigateToLogin
                ) {
                    EmptyView()
                }

            }.padding()
        }
    }
}

#Preview {
    CreateAccountView()
}

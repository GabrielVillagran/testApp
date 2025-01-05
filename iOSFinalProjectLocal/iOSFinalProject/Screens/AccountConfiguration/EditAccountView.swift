import Foundation
import SwiftUI

struct EditAccountView: View {

    @ObservedObject private var viewModel = CreateAccountViewModel()

    var body: some View {
        NavigationView {
            VStack {
                Label("My Account", systemImage: "person.crop.circle")
                    .font(.title)
                    .padding(90)

                LabelAndTextField(title: accountModification.newUserName.rawValue, inputPlaceHolder: CreateAccountStrings.usernamePlaceHolder.rawValue, inputBinder: $viewModel.name)
                    .onChange(of: viewModel.name) {
                        viewModel.validateUsername()
                    }

                LabelAndTextField(title: accountModification.newEmail.rawValue, inputPlaceHolder: CreateAccountStrings.emailPlaceHolder.rawValue, inputBinder: $viewModel.email)
                    .onChange(of: viewModel.email) {
                        viewModel.validateEmail()
                    }

                LabelAndTextField(title: accountModification.newPassword.rawValue, inputPlaceHolder: CreateAccountStrings.passwordPlaceHolder.rawValue, inputBinder: $viewModel.password)
                    .onChange(of: viewModel.password) {
                        viewModel.validatePassword()
                    }
                ErrorLabel(message: viewModel.validationStatus.rawValue)

                Spacer()
                Button(accountModification.saveChanges.rawValue) {
                }
                .font(.title2)
                .foregroundColor(.white)
                .padding(10)
                .frame(width: 350, height: 50)
                .background(Color.black)
                .cornerRadius(15)

                Button(accountModification.delete.rawValue)
                {
                }
                .font(.title2)
                .foregroundColor(.red)
                .padding(10)
                .frame(width: 350, height: 50)
                .background(Color.red.opacity(0.2))
                .cornerRadius(15)
            }.padding()
        }
    }
}

#Preview {
    EditAccountView()
}

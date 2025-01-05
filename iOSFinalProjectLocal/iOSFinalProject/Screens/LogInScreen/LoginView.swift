import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = LogInViewModel()

    var body: some View {
        NavigationStack {
            VStack {
                Label("LogIn", systemImage: "person.crop.circle")
                    .font(.title)
                    .padding(100)

                LabelAndTextField(title: "Email", inputPlaceHolder: "JohnDoe@gmail.com", inputBinder: $viewModel.email)
                    .padding()
                LabelAndTextField(title: "Password", inputPlaceHolder: "********", inputBinder: $viewModel.password, isSecure: true)
                    .padding()

                if viewModel.showError {
                    Text(viewModel.errorMessage)
                        .foregroundColor(.red)
                        .font(.caption)
                }

                Button("Forgotten Password") {
                    viewModel.forgotPassword()
                }
                .padding(10)
                .font(.title2)
                .foregroundColor(.gray)

                Button("Sign In") {
                    viewModel.SignIn()
                }
                .font(.title2)
                .foregroundColor(.white)
                .padding(10)
                .frame(width: 350, height: 50)
                .background(Color.black)
                .cornerRadius(15)

                Button("Become a member") {
                    viewModel.becomeMember()
                }

                .font(.title2)
                .foregroundColor(.black)
                .padding(10)
                .frame(width: 350, height: 50)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(15)

                NavigationLink(
                     destination: CreateAccountView(),
                     isActive: $viewModel.navigateToCreateAccount
                 ) {
                     EmptyView()
                 }
            }
            .navigationDestination(isPresented: $viewModel.isLoggedIn) {
                PokemonDisplayerViewWrapper()
            }
        }
    }
}

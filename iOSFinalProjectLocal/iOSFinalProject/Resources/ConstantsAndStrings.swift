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

enum StringsConstantsValue: String {
    case noUserNameOrPassword = "Please enter username and password."
    case username = "test@example.com"
    case password = "12345678"
    case invalidUserName = "Invalid Username or Password."
    case successfulLogin = "Login successful!"
}

enum accountModification: String {
    case newUserName = "Enter a new username"
    case newEmail = "Enter a new email"
    case newPassword = "Enter a new Password"
    case delete = "Delete Account"
    case saveChanges = "Save Changes"
}

enum Constants: Int {
    case minimumUsernameInputLength = 3
    case zeroValue = 0
}

enum FontSizes: CGFloat {
    case errorMessageLabelSize = 12
    case pokemonDetailsLabelFontSize = 22
    case pokemonDetailsStackViewFontSize = 16
}

enum GeneralCGFloatValues: CGFloat {
    case stackViewDetailsSpacing = 10
    case constraintConstantSpace = 20
    case constrainConstantBigSpace = 50
    case constraintConstantNegativeSpace = -20
    case constantHeightAnchor = 100
    case constantImageHeightAnchor = 300
    case constantImageWidthAnchor = 200
    case constantCornerRadius = 5
}

enum ErrorMessages: String {
    case errorFetchingData = "404 Not Found"
    case unexpectedError = "Connection Failure, reconnecting..."
}

enum DetailsScreenServiceConstants : String {
    case baseURL = "https://finalprojectpublic.onrender.com/"
}

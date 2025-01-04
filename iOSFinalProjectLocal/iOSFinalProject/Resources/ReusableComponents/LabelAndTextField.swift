//  LabelAndTextField.swift
//  SwiftUIandUIKit
//
//  Created by GenericDevCalifornia on 12/30/24.


import SwiftUI

struct LabelAndTextField: View {
    
    var title: String
    var inputPlaceHolder: String
    var inputBinder: Binding<String>
    var isSecure: Bool
    
    init(title: String, inputPlaceHolder: String, inputBinder: Binding<String>, isSecure: Bool = false) {
        self.title = title
        self.inputPlaceHolder = inputPlaceHolder
        self.inputBinder = inputBinder
        self.isSecure = isSecure
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title).bold()
            if isSecure {
                SecureField(inputPlaceHolder, text: inputBinder)
                    .textInputAutocapitalization(.never)
            } else {
                TextField(inputPlaceHolder, text: inputBinder)
                    .textInputAutocapitalization(.never)
            }
        }
    }
}

#Preview {
    LabelAndTextField(title: "Title", inputPlaceHolder: "Placeholder", inputBinder: .constant(""))
}

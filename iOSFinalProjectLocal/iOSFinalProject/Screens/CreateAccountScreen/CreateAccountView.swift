//
//  CreateAccountView.swift
//  TrainingFinalProject
//
//  Created by Trainee on 12/30/24.
//

import Foundation
import SwiftUI

struct CreateAccountView: View {
    @ObservedObject private var viewmodel = DependencyInitializer.container.resolve(CreateAccountViewModel.self)!

    var body: some View {
        NavigationView {
            VStack {
                Text(CreateAccountStrings.title.rawValue)
                    .font(.title)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .center)
                
                LabelAndTextField(title: CreateAccountStrings.nameLabel.rawValue, inputPlaceHolder: CreateAccountStrings.usernamePlaceHolder.rawValue, inputBinder: $viewmodel.name)
                    .onChange(of: viewmodel.name) {
                        viewmodel.validateUsername()
                    }
                
                LabelAndTextField(title: CreateAccountStrings.emailLabel.rawValue, inputPlaceHolder: CreateAccountStrings.emailPlaceHolder.rawValue, inputBinder: $viewmodel.email)
                    .onChange(of: viewmodel.email) {
                        viewmodel.validateEmail()
                    }
                
                LabelAndTextField(title: CreateAccountStrings.passwordLabel.rawValue, inputPlaceHolder: CreateAccountStrings.passwordPlaceHolder.rawValue, inputBinder: $viewmodel.password)
                    .onChange(of: viewmodel.password) {
                        viewmodel.validatePassword()
                    }
                ErrorLabel(message: viewmodel.validationStatus.rawValue)
                
                Spacer()
                Button(CreateAccountStrings.title.rawValue)
                {
                }
                .disabled(!viewmodel.validateInfo())
            }.padding()
        }
    }
}

#Preview {
    CreateAccountView()
}

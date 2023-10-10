//
//  SignUpEmailView.swift
//  SAFA
//
//  Created by Mirai DTN on 7/6/23.
//

import SwiftUI

struct SignUpEmailView: View {
    @StateObject private var viewModel = SignUpEmailViewModel()
    @EnvironmentObject var authenticationManager: AuthenticationManager
    @EnvironmentObject var userManager: UserManager
    
    var body: some View {
        Form {
            Section {
                TextField("Email", text: $viewModel.email)
                    .keyboardType(.emailAddress)
                    .autocorrectionDisabled(true)
                    .textInputAutocapitalization(.never)
                SecureField("Password", text: $viewModel.password)
                SecureField("Confirm Password", text: $viewModel.confirmPassword)
                if viewModel.invalidPassword {
                    FormFieldInfo("Must be at least 6 characters long containing a number or symbol")
                }
                if viewModel.unconfirmedPassword {
                    FormFieldInfo("Passwords do not match", color: .red)
                }
                NavigationLink("Next", destination: AdditionalInfoView(viewModel: viewModel))
                    .foregroundStyle(Color.accentColor)
                    .disabled(viewModel.invalidEmail || viewModel.invalidPassword || viewModel.unconfirmedPassword)
            } footer: {
                HStack {
                    Spacer()
                    NavigationLink("Already have an account?", destination: SignInEmailView())
                        .foregroundStyle(Color.accentColor)
                    Spacer()
                }
            }
        }
    }
}

#Preview("Sign Up With Email") {
    NavigationView {
        SignUpEmailView()
            .environmentObject(AuthenticationManager.mock)
            .environmentObject(UserManager())
    }
}

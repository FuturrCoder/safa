//
//  SignInEmailView.swift
//  SAFA
//
//  Created by Mirai H DTN on 10/7/23.
//

import SwiftUI

@MainActor
final class SignInEmailViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var error = ""
    
    func signIn(manager: AuthenticationManager) {
        Task {
            do {
                try await manager.signInUser(email: email, password: password)
            } catch {
                self.error = error.localizedDescription == "An internal error has occurred, print and inspect the error details for more information." ? "Invalid email or password" : error.localizedDescription
                print(error)
            }
        }
    }
}

struct SignInEmailView: View {
    @StateObject private var viewModel = SignInEmailViewModel()
    @EnvironmentObject var authenticationManager: AuthenticationManager
    
    var body: some View {
        Form {
            Section {
                TextField("Email", text: $viewModel.email)
                    .keyboardType(.emailAddress)
                    .autocorrectionDisabled(true)
                    .textInputAutocapitalization(.never)
                SecureField("Password", text: $viewModel.password)
                HStack {
                    Spacer()
                    Button("Sign In") {
                        viewModel.signIn(manager: authenticationManager)
                    }
                    .buttonStyle(.bordered)
                    Spacer()
                }
                if viewModel.error != "" {
                    FormFieldInfo(viewModel.error, color: .red)
                }
            } footer: {
                HStack {
                    Spacer()
                    NavigationLink("Forgot Password?", destination: ResetPasswordView())
                        .foregroundStyle(Color.accentColor)
                    Spacer()
                }
            }
        }
        .navigationTitle("Sign In")
    }
}

#Preview("Sign In With Email") {
    NavigationView {
        SignInEmailView()
            .environmentObject(AuthenticationManager.testing)
    }
}

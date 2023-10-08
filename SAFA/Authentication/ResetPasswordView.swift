//
//  ResetPasswordView.swift
//  SAFA
//
//  Created by Mirai H DTN on 10/8/23.
//

import SwiftUI

@MainActor
final class ResetPasswordViewModel: ObservableObject {
    @Published var email = ""
    @Published var message: String?
    @Published var messageTitle: String = ""
    @Published var showingAlert = false
    
    func resetPassword(manager: AuthenticationManager) {
        Task {
            do {
                try await manager.resetPassword(email: email)
                self.messageTitle = "Password reset email sent"
                self.message = "Follow the link in the email to reset your password"
                self.showingAlert = true
            } catch {
                self.messageTitle = "Error resetting password"
                self.message = error.localizedDescription
                self.showingAlert = true
            }
        }
    }
}

struct ResetPasswordView: View {
    @StateObject private var viewModel = ResetPasswordViewModel()
    @EnvironmentObject var authenticationManager: AuthenticationManager
    
    var body: some View {
        Form {
            Text("Enter your email address and we'll send you a link to reset your password.")
                .font(.caption)
            TextField("Email", text: $viewModel.email)
                .keyboardType(.emailAddress)
                .autocorrectionDisabled(true)
                .textInputAutocapitalization(.never)
            HStack {
                Spacer()
                Button("Send Reset Link") {
                    viewModel.resetPassword(manager: authenticationManager)
                }
                .buttonStyle(.bordered)
                Spacer()
            }
        }
        .alert(viewModel.messageTitle, isPresented: $viewModel.showingAlert) {
            Button("OK") {}
        } message: {
            Text(viewModel.message ?? "Try again later.")
        }
        .navigationTitle("Reset Password")
    }
}

#Preview("Reset Password") {
    NavigationView {
        ResetPasswordView()
    }
}

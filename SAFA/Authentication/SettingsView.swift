//
//  SettingsView.swift
//  SAFA
//
//  Created by Mirai H DTN on 9/1/23.
//

import SwiftUI

@MainActor
final class SettingsViewModel: ObservableObject {
    @Published var message: String?
    @Published var messageTitle: String = ""
    @Published var showingAlert = false
    
    func resetPassword(manager: AuthenticationManager) {
        guard let currentUser = manager.currentUser() else {
            self.messageTitle = "Unable to reset password"
            self.message = "Not logged in"
            self.showingAlert = true
            return
        }
        
        guard let email = currentUser.email else {
            self.messageTitle = "No email address found"
            self.message = "Please add an email address to reset your password"
            self.showingAlert = true
            return
        }
        
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
    
    func logOut(manager: AuthenticationManager) {
        do {
            try manager.logOut()
        } catch {
            self.messageTitle = "Error logging out"
            self.message = error.localizedDescription
            self.showingAlert = true
        }
    }
}

struct SettingsView: View {
    @StateObject private var viewModel = SettingsViewModel()
    @EnvironmentObject var authenticationManager: AuthenticationManager
    
    var body: some View {
        List {
            Button("Reset password") {
                viewModel.resetPassword(manager: authenticationManager)
            }
            Button("Log out") {
                viewModel.logOut(manager: authenticationManager)
            }
            .foregroundStyle(.red)
        }
        .alert(viewModel.messageTitle, isPresented: $viewModel.showingAlert) {
            Button("OK") {}
        } message: {
            Text(viewModel.message ?? "Try again later.")
        }
        .navigationTitle("Settings")
    }
}

#Preview("Settings View") {
    SettingsView()
        .environmentObject(AuthenticationManager.testing)
}

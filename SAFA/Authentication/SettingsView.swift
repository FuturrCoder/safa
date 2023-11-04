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
    @Published var showingDeleteAlert = false
    @Published var showSignInView = false
    
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
    
    func deleteAccount(authMan: AuthenticationManager, userMan: UserManager) {
        guard let currentUser = authMan.currentUserRaw() else {
            self.messageTitle = "Unable to delete account"
            self.message = "Not logged in"
            self.showingAlert = true
            return
        }
        
        Task {
            do {
                try await authMan.delete(user: currentUser, manager: userMan)
                self.messageTitle = "Account deleted"
                self.message = "Your account has been deleted"
                self.showingAlert = true
            } catch {
                self.messageTitle = "Error deleting account"
                self.message = error.localizedDescription
                self.showingAlert = true
            }
        }
    }
}

struct SettingsView: View {
    @StateObject private var viewModel = SettingsViewModel()
    @EnvironmentObject var authenticationManager: AuthenticationManager
    @EnvironmentObject var userManager: UserManager
    
    var body: some View {
        List {
            Section {
                Button("Reset password") {
                    viewModel.resetPassword(manager: authenticationManager)
                }
                Button("Log out", role: .destructive) {
                    viewModel.logOut(manager: authenticationManager)
                }
                Button("Delete account", role: .destructive) {
                    viewModel.showingDeleteAlert = true
                }
            }
            Section {
                Link("Privacy Policy", destination: URL(string: "https://www.safasport.org/legal")!)
                Link("Contact Support", destination: URL(string: "mailto:info@safasport.org")!)
            }
        }
        .alert(viewModel.messageTitle, isPresented: $viewModel.showingAlert) {
            Button("OK") {}
        } message: {
            Text(viewModel.message ?? "Try again later.")
        }
        .alert("Are you sure?", isPresented: $viewModel.showingDeleteAlert) {
            Button("Delete", role: .destructive) {
                viewModel.showSignInView = true
            }
        } message: {
            Text("This action cannot be undone. You will be asked to sign in again.")
        }
        .sheet(isPresented: $viewModel.showSignInView) {
            NavigationView {
                SignInEmailView(navigationTitle: "Sign In Again") {
                    viewModel.showSignInView = false
                    viewModel.deleteAccount(authMan: authenticationManager, userMan: userManager)
                }
            }
        }
        .navigationTitle("Settings")
    }
}

#Preview("Settings View") {
    NavigationView {
        SettingsView()
            .environmentObject(AuthenticationManager.mock)
    }
}

//
//  SignUpEmailView.swift
//  SAFA
//
//  Created by Mirai DTN on 7/6/23.
//

import SwiftUI

@MainActor
final class SignUpEmailViewModel: ObservableObject {
    @Published var name = ""
    @Published var email = ""
    @Published var password = ""
    @Published var birthday = Date.now
    @Published var isParent = false
    @Published var childName = ""
    @Published var error = ""
    
    var invalidName: Bool { name == "" }
    var invalidEmail: Bool {
        let pred = NSPredicate(format: "SELF MATCHES %@", "^[^@ ]+@[^@ ]+\\.[A-Za-z]{2,}$")
        return !pred.evaluate(with: email)
    }
    var invalidPassword: Bool {
        let pred = NSPredicate(format: "SELF MATCHES %@", "(?=.*(\\W|\\d)).{6,}")
        return !pred.evaluate(with: password)
    }
    var invalidBirthday: Bool {
        Calendar.current.dateComponents([.year], from: birthday, to: Date.now).year! < 13 && !isParent
    }
    var invalidChildName: Bool { childName == "" && isParent}
    var invalid: Bool {
        invalidName || invalidPassword || invalidEmail || invalidBirthday || invalidChildName
    }
    
    func signUp(manager: AuthenticationManager) {
        guard !invalid else { return }
        
        Task {
            do {
                let _ = try await manager.createUser(email: email, password: password)
            } catch {
                self.error = error.localizedDescription
            }
        }
    }
}

struct SignUpEmailView: View {
    @StateObject private var viewModel = SignUpEmailViewModel()
    @EnvironmentObject var authenticationManager: AuthenticationManager
    
    var body: some View {
        Form {
            Section {
                TextField("Your name", text: $viewModel.name)
                TextField("Email", text: $viewModel.email)
                    .keyboardType(.emailAddress)
                    .autocorrectionDisabled(true)
                    .textInputAutocapitalization(.never)
                SecureField("Password", text: $viewModel.password)
                if viewModel.invalidPassword {
                    FormFieldInfo("Must be at least 6 characters long containing a number or symbol")
                }
                Toggle("I'm a parent/guardian", isOn: $viewModel.isParent)
                if viewModel.isParent {
                    TextField("Child's Name", text: $viewModel.childName)
                }
                DatePicker(viewModel.isParent ? "Child's Date of Birth" : "Date of Birth",
                           selection: $viewModel.birthday,
                           in: Date(timeIntervalSince1970: 0)...Date.now,
                           displayedComponents: [.date])
                if viewModel.invalidBirthday {
                    FormFieldInfo("If you are under age 13, please ask a parent/guardian to create the account")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .listRowSeparator(.hidden, edges: .top)
                        .listRowInsets(EdgeInsets(top: 0, leading: 20, bottom: 5, trailing: 20))
                }
                HStack {
                    Spacer()
                    Button("Sign Up") {
                        viewModel.signUp(manager: authenticationManager)
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(viewModel.invalid)
                    Spacer()
                }
                if viewModel.error != "" {
                    FormFieldInfo(viewModel.error, color: .red)
                }
            } footer: {
                HStack {
                    Spacer()
                    NavigationLink("Already have an account?", destination: SignInEmailView())
                        .foregroundStyle(Color.accentColor)
//                    Button("test") {
//                        viewModel.email = "test"
//                    }
                    Spacer()
                }
            }
        }
    }
}

#Preview("Sign Up With Email") {
    NavigationView {
        SignUpEmailView()
            .environmentObject(AuthenticationManager.testing)
    }
}

//
//  NameAndAddressInput.swift
//  SAFA
//
//  Created by Mirai H DTN on 10/9/23.
//

import SwiftUI

struct NameAndAddressInput: View {
    @ObservedObject var viewModel: SignUpEmailViewModel
    @EnvironmentObject var authenticationManager: AuthenticationManager
    @EnvironmentObject var userManager: UserManager
    
    var body: some View {
        Section {
            HStack {
                TextField("First name", text: $viewModel.firstName)
                TextField("Last Name", text: $viewModel.lastName)
            }
            TextField("Address Line 1", text: $viewModel.addressLine1)
            TextField("Address Line 2", text: $viewModel.addressLine2)
            HStack {
                TextField("City", text: $viewModel.city)
                TextField("State", text: $viewModel.state)
                    .frame(maxWidth: 60)
                TextField("ZIP", text: $viewModel.zipCode)
                    .keyboardType(.numberPad)
                    .frame(maxWidth: 80)
            }
            HStack {
                Spacer()
                Button("Sign Up") {
                    viewModel.signUp(authManager: authenticationManager, userManager: userManager)
                }
                .buttonStyle(.borderedProminent)
                .disabled(viewModel.invalid)
                Spacer()
            }
            if viewModel.error != "" {
                FormFieldInfo(viewModel.error, color: .red)
            }
        } header: {
            Text("Name and Address")
        } footer: {
            Text("Currently, you must live in the U.S. to sign up.")
        }
    }
}

#Preview {
    NameAndAddressInput(viewModel: SignUpEmailViewModel())
}

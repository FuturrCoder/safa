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
                    .textContentType(.givenName)
                TextField("Last Name", text: $viewModel.lastName)
                    .textContentType(.familyName)
            }
            TextField("Address Line 1", text: $viewModel.addressLine1)
                .textContentType(.streetAddressLine1)
            TextField("Address Line 2", text: $viewModel.addressLine2)
                .textContentType(.streetAddressLine2)
            HStack {
                TextField("City", text: $viewModel.city)
                    .textContentType(.addressCity)
                TextField("State", text: $viewModel.state)
                    .frame(maxWidth: 60)
                    .textContentType(.addressState)
                TextField("ZIP", text: $viewModel.zipCode)
                    .keyboardType(.numberPad)
                    .frame(maxWidth: 80)
                    .textContentType(.postalCode)
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
            VStack(alignment: .leading) {
                Text("Currently, you must live in the U.S. to sign up.")
                Text("By signing up, you agree to our [Terms of Service and Privacy Policy](https://www.safasport.org/legal).")
            }
        }
    }
}

#Preview {
    NameAndAddressInput(viewModel: SignUpEmailViewModel())
}

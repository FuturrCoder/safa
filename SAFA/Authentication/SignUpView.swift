//
//  SignUpView.swift
//  SAFA
//
//  Created by Mirai DTN on 7/6/23.
//

import SwiftUI

@MainActor
final class SignUpViewModel: ObservableObject {
    
}

struct SignUpView: View {
    @StateObject private var viewModel = SignUpViewModel()
    
    var body: some View {
        VStack {
            SignUpEmailView()
        }
        .navigationTitle("Sign Up")
    }
}

#Preview("Sign Up") {
    NavigationView {
        SignUpView()
            .environmentObject(AuthenticationManager.testing)
    }
}

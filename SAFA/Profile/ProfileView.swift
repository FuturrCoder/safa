//
//  ProfileView.swift
//  SAFA
//
//  Created by Mirai DTN on 10/31/22.
//

import SwiftUI

@MainActor
final class ProfileViewModel: ObservableObject {
    @Published private(set) var user: AuthDataResult? = nil
    
    func loadCurrentUser(manager: AuthenticationManager) {
        self.user = manager.currentUser()
    }
}

struct ProfileView: View {
    // TODO: Make personal info fields editable
    // TODO: Link forms
    
    @StateObject private var viewModel = ProfileViewModel()
    @EnvironmentObject private var authenticationManager: AuthenticationManager
    @Binding var profile: Profile
//    let forms: [ApplicationForm]
    
    var body: some View {
        NavigationView {
            if let user = viewModel.user {
                List {
                    VStack {
                        ZStack {
                            Circle()
                                .foregroundStyle(Color("ThemeColor").opacity(0.5))
                                .frame(maxWidth: 70)
                            Image(systemName: "person.fill")
                                .font(.custom("test", fixedSize: 40))
                        }
                        Text("\(profile.firstName) \(profile.lastName)")
                            .font(.headline)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    Section {
                        InfoCard("Name", "Mirai Nishioka")
                        InfoCard("Email", user.email ?? "no email")
                        InfoCard("Age", "16")
                    } header: {
                        Text("Personal Info")
                    }
                }
                .appBar(title: "Profile")
            } else {
                Text("Error loading profile: not logged in")
                    .appBar(title: "Profile")
            }
        }
        .onAppear {
            viewModel.loadCurrentUser(manager: authenticationManager)
        }
    }
}

#Preview("Profile") {
    ProfileView(profile: .constant(Profile.sample))
        .environmentObject(AuthenticationManager.mock)
}

struct InfoCard: View {
    let key: String
    let value: String
    
    var body: some View {
        HStack {
            Text(key)
            Spacer()
            Text(value)
                .foregroundStyle(.secondary)
        }
    }
    
    init(_ key: String, _ value: String) {
        self.key = key
        self.value = value
    }
}

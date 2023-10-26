//
//  ProfileView.swift
//  SAFA
//
//  Created by Mirai DTN on 10/31/22.
//

import SwiftUI

@MainActor
final class ProfileViewModel: ObservableObject {
    @Published private(set) var user: UserData? = nil
    
    func loadCurrentUser(authMan: AuthenticationManager, userMan: UserManager) async {
        let authDataResult = authMan.currentUser()
        guard let authData = authDataResult else { return }
        user = try? await userMan.getUser(userId: authData.uid)
    }
}

struct ProfileView: View {
    // TODO: Make personal info fields editable
    // TODO: Link forms
    
    @StateObject private var viewModel = ProfileViewModel()
    @EnvironmentObject private var authenticationManager: AuthenticationManager
    @EnvironmentObject private var userManager: UserManager
//    @Binding var profile: Profile
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
                        Text(user.fullName)
                            .font(.headline)
                        if (user.isParent) {
                            Text("Parent")
                                .font(.subheadline)
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    Section {
                        InfoCard("Name", user.fullName)
                        InfoCard("Email", user.email)
                        InfoCard("Address", user.multiLineAddress)
                        if (user.isParent) {
                            InfoCard("Child Name", user.childFullName)
                            InfoCard("Child Birthday", user.birthdayShort)
                        } else {
                            InfoCard("Birthday", user.birthdayShort)
                        }
                    } header: {
                        Text("Personal Info")
                    }
                }
                .appBar(title: "Profile")
            } else {
                ProgressView()
                    .appBar(title: "Profile")
            }
        }
        .task {
            await viewModel.loadCurrentUser(authMan: authenticationManager, userMan: userManager)
        }
    }
}

#Preview("Profile") {
    ProfileView()
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

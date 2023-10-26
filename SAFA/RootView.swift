//
//  ContentView.swift
//  SAFA
//
//  Created by Mirai DTN on 10/28/22.
//

import SwiftUI
import FirebaseAuth

struct RootView: View {
//    @Binding var forms: [ApplicationForm]
//    @Binding var academies: [Academy]
//    @Binding var profile: Profile
    @State private var showSignUpView: Bool = false
    @State private var handle: AuthStateDidChangeListenerHandle?
    @EnvironmentObject var authenticationManager: AuthenticationManager
    
//    init() {
//        self._forms = forms
//        self._academies = academies
//        self._profile = profile
//    }
    
    var body: some View {
        TabView() {
            Group {
                FormsView()
                    .tabItem { Label("Forms", systemImage: "square.and.pencil") }
                    .tag(1)
                AcademiesView()
                    .tabItem { Label("Academies", systemImage: "building.2") }
                    .tag(2)
                ProfileView()
                    .tabItem { Label("Profile", systemImage: "person") }
                    .tag(3)
            }
        }
        .onAppear() {
//            showSignUpView = false
            if !authenticationManager.mock {
                showSignUpView = authenticationManager.currentUser() == nil
                handle = Auth.auth().addStateDidChangeListener { auth, user in
                    showSignUpView = user == nil
                    print("auth state changed: \(user.map{String(describing: AuthDataResult(user: $0))} ?? "no user")")
                    print("showSignUpView: \(showSignUpView)")
                }
            }
        }
        .onDisappear() {
            if !authenticationManager.mock {
                Auth.auth().removeStateDidChangeListener(handle!)
            }
        }
        .fullScreenCover(isPresented: $showSignUpView) {
            NavigationView {
                SignUpView()
            }
        }
    }
}

#Preview("Root View") {
    RootView()
        .environmentObject(AuthenticationManager.mock)
        .environmentObject(UserManager())
}

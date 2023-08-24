//
//  SAFAApp.swift
//  SAFA
//
//  Created by Mirai DTN on 10/28/22.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth

@main
struct SAFAApp: App {
    @StateObject private var formsStore = FormsStore()
    @StateObject private var academiesStore = AcademiesStore()
    @StateObject private var profileStore = ProfileStore()
    @StateObject private var authenticationManager: AuthenticationManager = AuthenticationManager()
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    init() {
//        FirebaseApp.configure()
//        _authenticationManager = StateObject(wrappedValue: AuthenticationManager(auth: Auth.auth()))
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView(forms: $formsStore.forms, academies: $academiesStore.academies, profile: $profileStore.profile)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

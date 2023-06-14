//
//  SAFAApp.swift
//  SAFA
//
//  Created by Mirai DTN on 10/28/22.
//

import SwiftUI

@main
struct SAFAApp: App {
    @StateObject private var formsStore = FormsStore()
    @StateObject private var academiesStore = AcademiesStore()
    @StateObject private var profileStore = ProfileStore()
    
    var body: some Scene {
        WindowGroup {
            ContentView(forms: $formsStore.forms, academies: $academiesStore.academies, profile: $profileStore.profile)
        }
    }
}

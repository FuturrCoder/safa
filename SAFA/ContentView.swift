//
//  ContentView.swift
//  SAFA
//
//  Created by Mirai DTN on 10/28/22.
//

import SwiftUI

struct ContentView: View {
    var formData: FormData
    
    var body: some View {
        TabView() {
            FormsView(formData: formData)
                .tabItem { Label("Forms", systemImage: "square.and.pencil") }
                .tag(1)
            AcademyView()
                .tabItem { Label("Academies", systemImage: "building.2") }
                .tag(2)
            ProfileView()
                .tabItem { Label("Profile", systemImage: "person") }
                .tag(3)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(formData: FormData())
    }
}

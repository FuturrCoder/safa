//
//  ContentView.swift
//  SAFA
//
//  Created by Mirai DTN on 10/28/22.
//

import SwiftUI

struct ContentView: View {
    @Binding var forms: [ApplicationForm]
    @Binding var academies: [Academy]
    
    init(forms: Binding<[ApplicationForm]>, academies: Binding<[Academy]>) {
        self._forms = forms
        self._academies = academies
//        UITabBar.appearance().barTintColor = UIColor(Color("ThemeColor"))
//        UITabBar.appearance().backgroundColor = UIColor(Color("ThemeColor"))
//        UITabBar.appearance().unselectedItemTintColor = UIColor(.black)
    }
    
    var body: some View {
        TabView() {
            Group {
                FormsView(forms: $forms)
                    .tabItem { Label("Forms", systemImage: "square.and.pencil") }
                    .tag(1)
                AcademiesView(academies: $academies)
                    .tabItem { Label("Academies", systemImage: "building.2") }
                    .tag(2)
                ProfileView()
                    .tabItem { Label("Profile", systemImage: "person") }
                    .tag(3)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(forms: .constant(ApplicationForm.sampleData), academies: .constant(Academy.sampleData))
    }
}

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
    @Binding var profile: Profile
    
    init(forms: Binding<[ApplicationForm]>, academies: Binding<[Academy]>, profile: Binding<Profile>) {
        self._forms = forms
        self._academies = academies
        self._profile = profile
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
                ProfileView(profile: $profile, forms: forms)
                    .tabItem { Label("Profile", systemImage: "person") }
                    .tag(3)
            }
        }
    }
}

extension View {
    func appBar(title: String) -> some View {
        self
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color("ThemeColor"), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {}) {
                        Image(systemName: "gearshape")
                    }
                    .frame(width: 30)
                    .foregroundColor(.black)
                }
                ToolbarItem(placement: .principal) {
                    Image("Logo White")
                        .resizable()
                        .scaledToFit()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {}) {
                        Image(systemName: "bell")
                    }
                    .frame(width: 30)
                    .foregroundColor(.black)
                }
            }
    }
    
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                        to: nil, from: nil, for: nil)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(forms: .constant(ApplicationForm.sampleData), academies: .constant(Academy.sampleData), profile: .constant(Profile.sample))
    }
}

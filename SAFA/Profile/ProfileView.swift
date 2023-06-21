//
//  ProfileView.swift
//  SAFA
//
//  Created by Mirai DTN on 10/31/22.
//

import SwiftUI

struct ProfileView: View {
    // TODO: Make personal info fields editable
    // TODO: Link forms
    
    @Binding var profile: Profile
//    let forms: [ApplicationForm]
    
    var body: some View {
        NavigationStack {
            List {
                VStack {
                    ZStack {
                        Circle()
                            .foregroundColor(Color("ThemeColor").opacity(0.5))
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
                    InfoCard("Email", "mnishioka@commschool.org")
                    InfoCard("Age", "16")
                } header: {
                    Text("Personal Info")
                }
//                Section {
//                    ForEach(forms) { form in
//                        Text(form.title)
//                    }
//                } header: {
//                    Text("Forms")
//                }
            }
            .appBar(title: "Profile")
        }
//        HStack {
//            Circle()
//                .foregroundColor(.white)
//                .border(.black)
//                .frame(maxWidth: 50)
//                .overlay() {
//                    Image(systemName: "person")
//                        .padding()
//                }
//            VStack(alignment: .leading) {
//                Text("Mirai DTN")
//                    .font(.title2)
//                Text("mnishioka@commschool.org")
//            }
//        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(profile: .constant(Profile.sample))
    }
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

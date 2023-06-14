//
//  AcademyDetail.swift
//  SAFA
//
//  Created by Mirai DTN on 11/14/22.
//

import SwiftUI

struct AcademyDetail: View {
    @Binding var academy: Academy
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                AsyncImage(url: URL(string: academy.icon)) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(maxHeight: 150)
                    } else if phase.error != nil {
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .frame(maxHeight: 150)
                    } else {
                        HStack {
                            Spacer()
                            ProgressView()
                                .frame(height: 150)
                            Spacer()
                        }
                    }
                }
                AcademyInfo(academy: $academy)
                    .padding()
            }
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AcademyInfo: View {
    @Binding var academy: Academy
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            VStack(alignment: .leading, spacing: 5) {
                HStack {
                    Text(academy.name)
                        .font(.largeTitle)
                        .bold()
                    Spacer()
                    Button(action: { academy.isFollowed = !academy.isFollowed }) {
                        Text(academy.isFollowed ? "Unfollow" : "Follow")
                    }
                }
                Label(academy.location, systemImage: "map")
                IconLink(link: academy.website, title: academy.website, systemName: "safari")
                if let email = academy.email {
                    IconLink(link: "mailto:\(email)", title: email, systemName: "envelope")
                }
                if let phoneNumber = academy.phoneNumber {
                    IconLink(link: "tel:\(phoneNumber)", title: phoneNumber, systemName: "phone")
                }
                if let tuition = academy.tuition {
                    Label("Tuition: \(tuition)", systemImage: "dollarsign.circle")
                }
                Label("Ages \(academy.ages)", systemImage: "person")
            }
            Text(academy.description)
                .font(.subheadline)
        }
    }
}

struct AcademyDetail_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AcademyDetail(academy: .constant(Academy.sample1))
        }
    }
}

struct IconLink: View {
    let link: String
    let title: String
    let systemName: String
    
    var body: some View {
        Section {
            if let url = URL(string: link) {
                Label {
                    Link(title, destination: url)
                } icon: {
                    Image(systemName: systemName)
                }
            }
        }
    }
}

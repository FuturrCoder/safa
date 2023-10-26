//
//  AcademyInfo.swift
//  SAFA
//
//  Created by Mirai H DTN on 10/24/23.
//

import SwiftUI

struct AcademyInfo: View {
    @Binding var academy: Academy
    @EnvironmentObject var userManager: UserManager
    @EnvironmentObject var authenticationManager: AuthenticationManager
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            VStack(alignment: .leading, spacing: 5) {
                HStack {
                    Text(academy.name)
                        .font(.largeTitle)
                        .bold()
                    Spacer()
                    FollowButton(academy: $academy)
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

#Preview("Academy Info") {
    AcademyInfo(academy: .constant(Academy.sample1))
}

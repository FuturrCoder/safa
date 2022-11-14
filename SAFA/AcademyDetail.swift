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
                Image(systemName: academy.icon)
                    .resizable()
                    .scaledToFill()
                    .frame(maxHeight: 150)
                    .clipped()
                Section {
                    HStack {
                        Text(academy.name)
                            .font(.largeTitle)
                            .bold()
                        Spacer()
                        Button(action: { academy.isFollowed = !academy.isFollowed }) {
                            if academy.isFollowed {
                                Text("Unfollow")
                            } else {
                                Text("Follow")
                            }
                        }
                    }
                    Text(academy.description)
                        .font(.subheadline)
                }
                .padding()
            }
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AcademyDetail_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AcademyDetail(academy: .constant(Academy.sample1))
        }
    }
}

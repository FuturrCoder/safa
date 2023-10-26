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

struct AcademyDetail_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
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

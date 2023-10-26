//
//  AcademyCard.swift
//  SAFA
//
//  Created by Mirai DTN on 11/14/22.
//

import SwiftUI

struct AcademyCard: View {
    @Binding var academy: Academy
    @EnvironmentObject private var authenticationManager: AuthenticationManager
    @EnvironmentObject private var userManager: UserManager
    
    var body: some View {
        HStack {
            ThumbnailImage(icon: academy.icon)
            VStack(alignment: .leading) {
                Text(academy.name)
                    .font(.title)
                    .foregroundStyle(.foreground)
                Text(academy.description)
                    .font(.caption)
                    .foregroundStyle(.foreground)
                    .multilineTextAlignment(.leading)
                    .lineLimit(3)
            }
            .padding(.leading, 10)
        }
        .padding([.bottom, .top])
    }
}

struct AcademyCard_Previews: PreviewProvider {
    static var previews: some View {
        AcademyCard(academy: .constant(Academy.sample1))
            .previewLayout(.sizeThatFits)
            .environmentObject(AuthenticationManager.mock)
            .environmentObject(UserManager())
    }
}

struct ThumbnailImage: View {
    let icon: String
    
    var body: some View {
        AsyncImage(url: URL(string: icon)) { phase in
            if let image = phase.image {
                image
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 60, maxHeight: 70)
            } else if phase.error != nil {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 60, maxHeight: 70)
            } else {
                HStack {
                    Spacer()
                    ProgressView()
                        .frame(height: 70)
                    Spacer()
                }
                .frame(width: 60)
            }
        }
    }
}

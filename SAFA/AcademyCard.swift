//
//  AcademyCard.swift
//  SAFA
//
//  Created by Mirai DTN on 11/14/22.
//

import SwiftUI

struct AcademyCard: View {
    let academy: Academy
    
    var body: some View {
        HStack {
            ThumbnailImage(icon: academy.icon)
            VStack(alignment: .leading) {
                Text(academy.name)
                    .font(.title)
                Text(academy.description)
                    .font(.caption)
                    .lineLimit(3)
            }
            .padding(.leading)
        }
        .padding([.bottom, .top])
    }
}

struct AcademyCard_Previews: PreviewProvider {
    static var previews: some View {
        AcademyCard(academy: Academy.sample1)
            .previewLayout(.sizeThatFits)
    }
}

struct ThumbnailImage: View {
    let icon: String
    
    var body: some View {
        Image(systemName: icon)
            .resizable()
            .scaledToFill()
            .frame(maxWidth: 60, maxHeight: 60)
            .clipped()
            .cornerRadius(10)
    }
}

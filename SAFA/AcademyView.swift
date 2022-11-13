//
//  AcademyView.swift
//  SAFA
//
//  Created by Mirai DTN on 10/30/22.
//

import SwiftUI

struct AcademyView: View {
    var body: some View {
        NavigationView {
            VStack {
                AcademyCard()
                AcademyCard()
                Spacer()
            }
            .navigationTitle("Academies")
        }
        
        // follow different academies
        // each academy has its own profile
    }
}

struct AcademyView_Previews: PreviewProvider {
    static var previews: some View {
        AcademyView()
    }
}

struct AcademyCard: View {
    var body: some View {
        Button(action: {}) {
            HStack {
                Image(systemName: "photo")
                    .padding()
                VStack(alignment: .leading) {
                    Text("Academy 1")
                        .font(.title2)
                    Text("This is a short-ish description of the academy")
                        .multilineTextAlignment(.leading)
                }
            }
            .padding()
        }
        .foregroundColor(.black)
        .padding()
        .buttonStyle(.bordered)
    }
}

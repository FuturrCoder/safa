//
//  AcademyView.swift
//  SAFA
//
//  Created by Mirai DTN on 10/30/22.
//

import SwiftUI

struct AcademiesView: View {
    @Binding var academies: [Academy]
    
    var body: some View {
        NavigationView {
            List {
                ForEach($academies) { $academy in
                    NavigationLink(destination: AcademyDetail(academy: $academy)) {
                        AcademyCard(academy: academy)
                    }
                    .listRowSeparator(.hidden)
                }
            }
            .navigationTitle("Academies")
        }
        
        // follow different academies
        // each academy has its own profile
    }
}

struct AcademyView_Previews: PreviewProvider {
    static var previews: some View {
        AcademiesView(academies: .constant(Academy.sampleData))
    }
}

//struct AcademyCard: View {
//    var body: some View {
//        Button(action: {}) {
//            HStack {
//                Image(systemName: "photo")
//                    .padding()
//                VStack(alignment: .leading) {
//                    Text("Academy 1")
//                        .font(.title2)
//                    Text("This is a short-ish description of the academy")
//                        .multilineTextAlignment(.leading)
//                }
//            }
//            .padding()
//        }
//        .foregroundColor(.black)
//        .padding()
//        .buttonStyle(.bordered)
//    }
//}

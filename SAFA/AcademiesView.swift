//
//  AcademyView.swift
//  SAFA
//
//  Created by Mirai DTN on 10/30/22.
//

import SwiftUI

struct AcademiesView: View {
    // TODO: Add search
    
    @Binding var academies: [Academy]
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    ForEach($academies) { $academy in
                        NavigationLink(destination: AcademyDetail(academy: $academy)) {
                            AcademyCard(academy: academy)
                        }
                        .listRowSeparator(.hidden)
                    }
                } header: {
                    Text("Academies")
                        .font(.largeTitle)
                        .bold()
                        .padding(.top)
                }
                .headerProminence(.increased)
            }
            .appBar(title: "Academies")
        }
    }
}

struct AcademyView_Previews: PreviewProvider {
    static var previews: some View {
        AcademiesView(academies: .constant(Academy.sampleData))
    }
}

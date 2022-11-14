//
//  FormsView.swift
//  SAFA
//
//  Created by Mirai DTN on 10/29/22.
//

import SwiftUI
import PhotosUI

struct FormsView: View {
    @Binding var forms: [ApplicationForm]
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    ForEach($forms) { $form in
                        NavigationLink(destination: FormView(form: $form)) {
                            FormCard(form: form)
                        }
                        .listRowSeparator(.hidden)
                    }
                } header: {
                    Text("Forms")
                        .font(.largeTitle)
                        .bold()
                        .padding(.top)
                }
                .headerProminence(.increased)
            }
            .appBar(title: "Forms")
        }
        
        // TODO: once filled out, appears on profile
    }
}

struct FormsView_Previews: PreviewProvider {
    static var previews: some View {
        FormsView(forms: .constant(ApplicationForm.sampleData))
    }
}

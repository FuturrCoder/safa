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
        NavigationView {
            List {
                ForEach($forms) { $form in
                    NavigationLink(destination: FormView(form: $form)) {
                        FormCard(form: form)
                    }
                    .listRowSeparator(.hidden)
                }
            }
            .navigationTitle("Forms")
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Image("Logo White")
                        .resizable()
                        .scaledToFit()
                }
            }
        }
        
        // TODO: once filled out, appears on profile
    }
}

struct FormsView_Previews: PreviewProvider {
    static var previews: some View {
        FormsView(forms: .constant(ApplicationForm.sampleData))
    }
}

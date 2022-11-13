//
//  FormView.swift
//  SAFA
//
//  Created by Mirai DTN on 11/10/22.
//

import SwiftUI

struct FormView: View {
    @ObservedObject var formData: FormData
    
    var body: some View {
        Form {
            Section {
                Text("Describe your skill level and experience in a couple of sentences")
                TextEditor(text: $formData.experience)
            }
            Section {
                Text("Describe your financial situation")
                TextEditor(text: $formData.financial)
            }
            Section {
                Text("Upload a photo of your playing")
                UploadButton(formData: formData)
            }
        }
    }
}

struct FormView_Previews: PreviewProvider {
    static var previews: some View {
        FormView(formData: FormData())
    }
}

//
//  FormView.swift
//  SAFA
//
//  Created by Mirai DTN on 11/10/22.
//

import SwiftUI

struct FormView: View {
    @Binding var form: ApplicationForm
//    var test: FormItem.Response = ApplicationForm.samplePersonal[0].response
    
    var body: some View {
        Form {
            ForEach($form.items) { $item in
                Section {
                    Text(item.prompt)
                    
                }
            }
//            Section {
//                Text("Describe your skill level and experience in a couple of sentences")
//                TextEditor(text: $formData.experience)
//            }
//            Section {
//                Text("Describe your financial situation")
//                TextEditor(text: $formData.financial)
//            }
//            Section {
//                Text("Upload a photo of your playing")
//                UploadButton(formData: formData)
//            }
        }
        .navigationTitle(form.title)
    }
}

struct FormView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            FormView(form: .constant(ApplicationForm.sampleData[0]))
        }
    }
}

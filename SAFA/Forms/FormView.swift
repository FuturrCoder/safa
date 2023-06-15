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
        if (form.pages.count > 1) {
            HStack {
                ProgressView(value: form.progress)
                Text("\(Int(round(form.progress)))%")
            }
            .padding([.leading, .trailing])
        }
        Form {
            ForEach($form.pages[form.current].items) { $item in
                FormQuestion(item: $item)
            }
        }
        .navigationTitle(form.title)
    }
}

struct FormView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            FormView(form: .constant(ApplicationForm.sampleData[2]))
        }
    }
}

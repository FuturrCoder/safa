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
//        if (form.pages.count > 1) {
            HStack {
                ProgressView(value: form.progress)
                    .animation(.easeInOut(duration: 0.7), value: form.progress)
//                    .onChange(of: form.progress) { newValue in
//                        print("\(form.answered),\(form.unanswered)")
//                    }
                Text("\(Int(floor(form.progress * 100)))%")
            }
            .padding([.leading, .trailing])
//        }
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

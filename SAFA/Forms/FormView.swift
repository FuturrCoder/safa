//
//  FormView.swift
//  SAFA
//
//  Created by Mirai DTN on 11/10/22.
//

import SwiftUI

struct FormView: View {
    @Binding var form: ApplicationForm
    @State var current: Int
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
        TabView(selection: $current) {
            ForEach(0..<form.viewable.count, id: \.self) { i in
                Form {
                    if form.pages[form.viewable[i]].description != "" {
                        Text(form.pages[form.viewable[i]].description)
                            .italic()
                            .foregroundColor(.secondary)
                            .listRowBackground(Color(UIColor.systemGroupedBackground))
                            .padding(-15)
                    }
                    ForEach($form.pages[form.viewable[i]].items) { $item in
                        FormQuestion(item: $item, form: $form)
                    }
                }
            }
        }
        .onChange(of: current) { form.current = $0 }
        .tabViewStyle(.page)
        .indexViewStyle(.page(backgroundDisplayMode: .interactive))
        .navigationTitle(form.title)
    }
    
    init(form: Binding<ApplicationForm>) {
        self._form = form
        self._current = .init(initialValue: form.current.wrappedValue)
    }
}

struct FormView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            FormView(form: .constant(ApplicationForm.sampleData[2]))
        }
    }
}

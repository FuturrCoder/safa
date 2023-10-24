//
//  FormView.swift
//  SAFA
//
//  Created by Mirai DTN on 11/10/22.
//

import SwiftUI

@MainActor
final class FormViewModel: ObservableObject {
    func updateForm(form: ApplicationForm, manager: AuthenticationManager) async throws {
        let authDataResult = manager.currentUser()
        guard let authData = authDataResult else { return }
        try await FormManager().updateForm(form: form, userId: authData.uid)
    }
}

struct FormView: View {
    @Binding var form: ApplicationForm
    @StateObject private var viewModel = FormViewModel()
    @State var current: Int
//    var test: FormItem.Response = ApplicationForm.samplePersonal[0].response
    
    var body: some View {
//        if (form.pages.count > 1) {
        FormProgress(progress: form.progress, completed: form.completed)
            .padding([.leading, .trailing])
//        }
        TabView(selection: $current) {
            ForEach(0..<form.viewable.count, id: \.self) { i in
                VStack {
                    Form {
                        if form.pages[form.viewable[i]].description != "" {
                            Text(form.pages[form.viewable[i]].description)
                                .italic()
                                .foregroundStyle(.secondary)
                                .listRowBackground(Color(UIColor.systemGroupedBackground))
                                .padding(-15)
                        }
                        ForEach($form.pages[form.viewable[i]].items) { $item in
                            FormQuestion(item: $item, form: $form)
                        }
                    }
                }
            }
        }
        .onChange(of: form) { newValue in
            Task {
                do {
                    try await viewModel.updateForm(form: newValue, manager: AuthenticationManager())
                } catch {
                    print(error)
                }
            }
        }
        .onChange(of: current) { form.current = $0 }
        .tabViewStyle(.page)
        .indexViewStyle(.page(backgroundDisplayMode: .interactive))
        .animation(.easeInOut, value: current)
        .animation(.easeInOut, value: form.current)
        .navigationTitle(form.title)
        FormButtons(form: $form, current: $current)
            .padding(EdgeInsets(top: 0, leading: 10, bottom: 5, trailing: 10))
    }
    
    init(form: Binding<ApplicationForm>) {
        self._form = form
        self._current = .init(initialValue: form.current.wrappedValue)
    }
}

struct FormView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            FormView(form: .constant(ApplicationForm.sampleData[0]))
        }
    }
}

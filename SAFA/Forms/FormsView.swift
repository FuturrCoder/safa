//
//  FormsView.swift
//  SAFA
//
//  Created by Mirai DTN on 10/29/22.
//

import SwiftUI
import PhotosUI

@MainActor
final class FormsViewModel: ObservableObject {
    @Published var formsStore: FormsStore = FormsStore(forms: [])
    private var formManager = FormManager()
    
    func loadForms(manager: AuthenticationManager) async {
        let authDataResult = manager.currentUser()
        guard let authData = authDataResult else { return }
        do {
//            print("loading forms")
            formsStore = try await FormsStore(forms: FormManager()
                .getForms(userId: authData.uid))
//            print("forms loaded")
//            print(formsStore.forms[0].pages[5].items[0])
        } catch {
            print("could not load forms" + error.localizedDescription)
            formsStore = FormsStore(forms: [])
        }
    }
    
//    func uploadForms() async throws {
//        try formManager.uploadForms()
//    }
    
//    func addDefaultForms(manager: AuthenticationManager) async throws {
//        let authDataResult = manager.currentUser()
//        guard let authData = authDataResult else { return }
//        try await FormManager().addDefaultForms(userId: authData.uid)
//    }
}

struct FormsView: View {
    // TODO: Make home on menu bar link to this view
    // TODO: Replace search button in navigation bar
    
//    @Binding var forms: [ApplicationForm]
    @StateObject private var viewModel = FormsViewModel()
    @EnvironmentObject private var authenticationManager: AuthenticationManager
    
    var body: some View {
        NavigationView {
            if !viewModel.formsStore.forms.isEmpty {
                List {
                    Section {
                        ForEach($viewModel.formsStore.forms) { $form in
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
            } else {
                ProgressView()
                    .appBar(title: "Forms")
            }
        }
        .onChange(of: authenticationManager.reload) {
            if $0 {
                Task {
                    await viewModel.loadForms(manager: authenticationManager)
                }
            }
        }
        .task {
//            do {
//                try await viewModel.uploadForms()
//            } catch {
//                print("Error uploading forms: \(error)")
//            }
//            do {
//                try await viewModel.addDefaultForms(manager: authenticationManager)
//            } catch {
//                print("Error adding default forms: \(error)")
//            }
            await viewModel.loadForms(manager: authenticationManager)
        }
    }
}

struct FormsView_Previews: PreviewProvider {
    static var previews: some View {
        FormsView()
    }
}

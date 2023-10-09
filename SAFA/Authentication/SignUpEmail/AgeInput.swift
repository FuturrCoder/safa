//
//  AgeInput.swift
//  SAFA
//
//  Created by Mirai H DTN on 10/9/23.
//

import SwiftUI

struct AgeInput: View {
    @ObservedObject var viewModel: SignUpEmailViewModel
    
    var body: some View {
        Section {
            Toggle("I'm a parent/guardian", isOn: $viewModel.isParent)
            if viewModel.isParent {
                TextField("Child's Name", text: $viewModel.childName)
            }
            DatePicker(viewModel.isParent ? "Child's Date of Birth" : "Date of Birth",
                       selection: $viewModel.birthday,
                       in: Date(timeIntervalSince1970: 0)...Date.now,
                       displayedComponents: [.date])
            if viewModel.invalidBirthday {
                FormFieldInfo("If you are under age 13, please ask a parent/guardian to create the account")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .listRowSeparator(.hidden, edges: .top)
                    .listRowInsets(EdgeInsets(top: 0, leading: 20, bottom: 5, trailing: 20))
            }
        } header: {
            Text("Age")
        }
    }
}

#Preview {
    AgeInput(viewModel: SignUpEmailViewModel())
}

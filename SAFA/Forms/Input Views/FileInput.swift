//
//  FileInput.swift
//  SAFA
//
//  Created by Mirai DTN on 6/13/23.
//

import SwiftUI

struct FileInput: View {
    @Binding var isAnswered: Bool
    var isRequired: Bool
    @Binding var response: FileResponse
    @EnvironmentObject var footer: Footer
    @State private var input: String
    @FocusState private var focused: Bool
    
    var valid: Bool {
        input.contains("drive.google.com")
    }
    
    var body: some View {
        TextField("Google Drive Link", text: $input)
            .keyboardType(.URL)
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled()
            .focused($focused)
            .onChange(of: focused) { _ in
//                if valid {
                    response.input = URL(string: input)
//                }
            }
            .onChange(of: input) { newValue in
                updateFooter(input: newValue)
                isAnswered = valid
            }
            .onAppear {
                updateFooter(input: input)
            }
    }
    
    func updateFooter(input newInput: String) {
        footer.text = valid ? "" : "Please enter a valid Google Drive link"
        footer.color = !valid && isRequired ? .red : .secondary
    }
    
    init(isAnswered: Binding<Bool>, isRequired: Bool, response: Binding<FileResponse>) {
        self._isAnswered = isAnswered
        self.isRequired = isRequired
        self._response = response
        self._input = .init(initialValue: response.input.wrappedValue?.absoluteString ?? "")
    }
}

struct FileInput_Previews: PreviewProvider {
    static var previews: some View {
        FileInput(isAnswered: .constant(true), isRequired: true, response: .constant(FileResponse()))
    }
}

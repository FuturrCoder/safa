//
//  VideoInput.swift
//  SAFA
//
//  Created by Mirai DTN on 6/13/23.
//

import SwiftUI

struct VideoInput: View {
    @Binding var isAnswered: Bool
    var isRequired: Bool
    @Binding var response: VideoResponse
    @EnvironmentObject var footer: Footer
    @State private var input: String
    @FocusState private var focused: Bool
    
    var valid: Bool {
        input.contains("youtube.com") || input.contains("youtu.be") || input.contains("drive.google.com")
    }
    
    var body: some View {
//        Button {} label: {
//            Spacer()
//            Image(systemName: "plus")
//            Spacer()
//        }
//        .onAppear { isAnswered = true }
        TextField("Youtube or Google Drive Link", text: $input)
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
        footer.text = valid ? "" : "Please enter a valid YouTube or Google Drive video link"
        footer.color = !valid && isRequired ? .red : .secondary
    }
    
    init(isAnswered: Binding<Bool>, isRequired: Bool, response: Binding<VideoResponse>) {
        self._isAnswered = isAnswered
        self.isRequired = isRequired
        self._response = response
        self._input = .init(initialValue: response.input.wrappedValue?.absoluteString ?? "")
    }
}

struct VideoInput_Previews: PreviewProvider {
    static var previews: some View {
        VideoInput(isAnswered: .constant(true), isRequired: true, response: .constant(VideoResponse()))
            .environmentObject(Footer())
    }
}

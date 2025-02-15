//
//  LongInput.swift
//  SAFA
//
//  Created by Mirai DTN on 6/13/23.
//

import SwiftUI

struct LongInput: View {
    @Binding var isAnswered: Bool
    var isRequired: Bool
    @Binding var response: LongAnswer
    @EnvironmentObject var footer: Footer
    @State private var input: String
    @FocusState private var focused: Bool
    
    var body: some View {
        TextEditor(text: $input)
            .focused($focused)
            .onChange(of: focused) { _ in
                response.input = String(input.prefix(response.range.upperBound))
                input = response.input
            }
            .onChange(of: input) { newValue in
                updateFooter(input: newValue)
                isAnswered = newValue.count >= response.range.lowerBound
            }
            .onAppear {
                updateFooter(input: input)
            }
    }
    
    func updateFooter(input newInput: String) {
        footer.text = "\(newInput.count)/\(response.range.upperBound) characters"
        footer.color = response.range.contains(newInput.count) || !isRequired ? .secondary : .red
    }
    
    init(isAnswered: Binding<Bool>, isRequired: Bool, response: Binding<LongAnswer>) {
        self._isAnswered = isAnswered
        self.isRequired = isRequired
        self._response = response
        self.input = response.input.wrappedValue
    }
}

struct LongInput_Previews: PreviewProvider {
    static var previews: some View {
        LongInput(isAnswered: .constant(true), isRequired: true, response: .constant(LongAnswer(input: "This is an answer that may or may not be slightly long. In fact, when I think about it, it seems, however, to be rather decently long.")))
            .environmentObject(Footer())
    }
}

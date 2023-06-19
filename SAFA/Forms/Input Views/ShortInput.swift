//
//  ShortInput.swift
//  SAFA
//
//  Created by Mirai DTN on 6/13/23.
//

import SwiftUI

struct ShortInput: View {
    @Binding var isAnswered: Bool
    var isRequired: Bool
    @Binding var response: ShortAnswer
    @EnvironmentObject var footer: Footer
    @State private var input: String
    @FocusState private var focused: Bool
    
    var body: some View {
        TextField("", text: $input)
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
    
    init(isAnswered: Binding<Bool>, isRequired: Bool, response: Binding<ShortAnswer>) {
        self._isAnswered = isAnswered
        self.isRequired = isRequired
        self._response = response
        self._input = .init(wrappedValue: response.input.wrappedValue)
    }
}

struct ShortInput_Previews: PreviewProvider {
    static var previews: some View {
        ShortInput(isAnswered: .constant(true), isRequired: true, response: .constant(ShortAnswer(input: "This is pretty short", range: 1...100)))
            .environmentObject(Footer())
    }
}

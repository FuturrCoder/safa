//
//  ShortInput.swift
//  SAFA
//
//  Created by Mirai DTN on 6/13/23.
//

import SwiftUI

struct ShortInput: View {
    @Binding var isAnswered: Bool
    @Binding var response: ShortAnswer
    var prompt: String
    @State private var input: String
    @FocusState private var focused: Bool
    
    var body: some View {
        Section {
            Text(prompt)
            TextField("", text: $input)
                .focused($focused)
                .onChange(of: focused) { _ in
                    response.input = String(input.prefix(response.range.upperBound))
                    input = response.input
                }
        } footer: {
            Text("\(input.count)/\(response.range.upperBound) characters")
                .foregroundColor(input.count > response.range.upperBound ? .red : .gray)
        }
    }
    
    init(isAnswered: Binding<Bool>, response: Binding<ShortAnswer>, prompt: String) {
        self._isAnswered = isAnswered
        self._response = response
        self._input = .init(wrappedValue: response.input.wrappedValue)
        self.prompt = prompt
    }
}

struct ShortInput_Previews: PreviewProvider {
    static var previews: some View {
        ShortInput(isAnswered: .constant(true), response: .constant(ShortAnswer(input: "This is pretty short", range: 1...100)), prompt: "Answer this question concisely")
    }
}

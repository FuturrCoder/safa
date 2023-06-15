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
    @State private var input: String
    @FocusState private var focused: Bool
    
    var body: some View {
        TextField("", text: $response.input)
            .focused($focused)
            .onChange(of: focused) { _ in
                response.input = input
            }
    }
    
    init(isAnswered: Binding<Bool>, response: Binding<ShortAnswer>) {
        self._isAnswered = isAnswered
        self._response = response
        self._input = .init(wrappedValue: response.input.wrappedValue)
    }
}

struct ShortInput_Previews: PreviewProvider {
    static var previews: some View {
        ShortInput(isAnswered: .constant(true), response: .constant(ShortAnswer(input: "This is pretty short", range: 1...100)))
    }
}

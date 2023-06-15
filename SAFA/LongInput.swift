//
//  LongInput.swift
//  SAFA
//
//  Created by Mirai DTN on 6/13/23.
//

import SwiftUI

struct LongInput: View {
    @Binding var isAnswered: Bool
    @Binding var response: LongAnswer
    var prompt: String
    @State private var input: String
    @FocusState private var focused: Bool
    
    var body: some View {
        Section {
            Text(prompt)
            TextField("", text: $input, axis: .vertical)
                .focused($focused)
                .onChange(of: focused) { _ in
                    response.input = String(input.prefix(response.range.upperBound))
                    input = response.input
                }
                .lineLimit(1...10)
//            HStack {
//                Text("\(input.count)/\(response.range.upperBound) characters")
//                    .font(.caption)
//                    .foregroundColor(input.count > response.range.upperBound ? .red : .gray)
//                Spacer()
//            }
        } footer: {
            Text("\(input.count)/\(response.range.upperBound) characters")
                .foregroundColor(input.count > response.range.upperBound ? .red : .gray)
        }
//        .frame(maxHeight: focused ? 500 : 100)
//        .frame(maxHeight: 300)
    }
    
    init(isAnswered: Binding<Bool>, response: Binding<LongAnswer>, prompt: String) {
        self._isAnswered = isAnswered
        self._response = response
        self._input = .init(wrappedValue: response.input.wrappedValue)
        self.prompt = prompt
    }
}

struct LongInput_Previews: PreviewProvider {
    static var previews: some View {
        LongInput(isAnswered: .constant(true), response: .constant(LongAnswer(input: "This is an answer that may or may not be slightly long. In fact, when I think about it, it seems, however, to be rather decently long.")), prompt: "What is the answer?")
    }
}

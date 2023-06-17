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
    @EnvironmentObject var footer: Footer
    @State private var input: String
    @FocusState private var focused: Bool
    
    var body: some View {
//        Section {
//            Text(prompt)
//            TextField("", text: $input, axis: .vertical)
        TextEditor(text: $input)
            .focused($focused)
            .onChange(of: focused) { _ in
                response.input = String(input.prefix(response.range.upperBound))
                input = response.input
            }
            .onChange(of: input) { newValue in
                updateFooter(input: newValue)
            }
            .onAppear {
                updateFooter(input: input)
            }
//                .lineLimit(1...)
//            HStack {
//                Text("\(input.count)/\(response.range.upperBound) characters")
//                    .font(.caption)
//                    .foregroundColor(input.count > response.range.upperBound ? .red : .gray)
//                Spacer()
//            }
//        } footer: {
//            Text("\(input.count)/\(response.range.upperBound) characters")
//                .foregroundColor(input.count > response.range.upperBound ? .red : .gray)
//        }
//        .frame(maxHeight: focused ? 500 : 100)
//        .frame(maxHeight: 300)
//        .lineLimit(1...10)
    }
    
//    var footer: Text {
//        Text("\(input.count)/\(response.range.upperBound) characters")
//            .foregroundColor(input.count > response.range.upperBound ? .red : .gray)
//    }
    
    func updateFooter(input newInput: String) {
        footer.text = "\(newInput.count)/\(response.range.upperBound) characters"
        footer.color = newInput.count > response.range.upperBound ? .red : .secondary
    }
    
    init(isAnswered: Binding<Bool>, response: Binding<LongAnswer>, prompt: String) {
        self._isAnswered = isAnswered
        self._response = response
        self._input = .init(wrappedValue: response.input.wrappedValue)
        self.prompt = prompt
//        updateFooter(input: response.input.wrappedValue)
    }
}

struct LongInput_Previews: PreviewProvider {
    static var previews: some View {
        LongInput(isAnswered: .constant(true), response: .constant(LongAnswer(input: "This is an answer that may or may not be slightly long. In fact, when I think about it, it seems, however, to be rather decently long.")), prompt: "What is the answer?")
    }
}

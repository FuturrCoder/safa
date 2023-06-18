//
//  IntInput.swift
//  SAFA
//
//  Created by Mirai DTN on 6/13/23.
//

import SwiftUI

struct IntInput: View {
    @Binding var isAnswered: Bool
    @Binding var response: IntResponse
    @State private var input: String
    @FocusState private var focused: Bool
    @EnvironmentObject var footer: Footer
    
    var body: some View {
        TextField("", text: $input)
            .keyboardType(.numberPad)
            .focused($focused)
            .onChange(of: focused) { _ in
                if let n = Int(input) {
                    response.input = n.clamped(to: response.range)
                    input = String(response.input)
                } else {
                    response.input = 0
                    input = ""
                }
            }
            .onChange(of: input) { newValue in
                if let n = Int(input) {
                    if response.range.contains(n) {
                        isAnswered = true
                        footer.text = ""
                    } else {
                        isAnswered = false
                        footer.text = "Please enter a number between \(response.range.lowerBound) and \(response.range.upperBound)"
                    }
                } else if input == "" {
                    isAnswered = false
                    footer.text = ""
                } else {
                    isAnswered = false
                    footer.text = "Please enter a valid whole number"
                }
            }
            .onAppear { footer.color = .red }
    }
    
    init(isAnswered: Binding<Bool>, response: Binding<IntResponse>) {
        self._isAnswered = isAnswered
        self._response = response
        self.input = isAnswered.wrappedValue ? String(response.input.wrappedValue) : ""
    }
}

extension Int {
    func clamped(to range: ClosedRange<Int>) -> Int {
        Swift.min(Swift.max(self, range.lowerBound), range.upperBound)
    }
}

//extension ClosedRange {
//    func clamp(_ value: Bound) -> Bound {
//        Swift.min(Swift.max(value, self.lowerBound), self.upperBound)
//    }
//}

struct IntInput_Previews: PreviewProvider {
    static var previews: some View {
        IntInput(isAnswered: .constant(true), response: .constant(IntResponse(input: 10, range: 1...10)))
            .environmentObject(Footer())
    }
}

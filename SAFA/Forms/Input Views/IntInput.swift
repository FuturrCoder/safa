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
    //    @State var input: String
    @State var invalid: Bool = false
    
    var body: some View {
        TextField("", value: $response.input, format: .number)
            .keyboardType(.numberPad)
            .onChange(of: response.input) { newValue in
                if !response.range.contains(newValue) {
                    invalid = true
                    isAnswered = false
                } else {
                    invalid = false
                    isAnswered = true
                }
            }
        if invalid {
            Text("Please enter a number between \(response.range.lowerBound) and \(response.range.upperBound)")
                .foregroundColor(.red)
        }
    }
}

struct IntInput_Previews: PreviewProvider {
    static var previews: some View {
        IntInput(isAnswered: .constant(true), response: .constant(IntResponse(input: 10, range: 1...10)))
    }
}

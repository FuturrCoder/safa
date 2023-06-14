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
    
    var body: some View {
        TextField("", text: $response.input)
    }
}

struct ShortInput_Previews: PreviewProvider {
    static var previews: some View {
        ShortInput(isAnswered: .constant(true), response: .constant(ShortAnswer(input: "This is pretty short", range: 1...100)))
    }
}

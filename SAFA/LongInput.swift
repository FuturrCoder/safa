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
    
    var body: some View {
        TextEditor(text: $response.input)
    }
}

struct LongInput_Previews: PreviewProvider {
    static var previews: some View {
        LongInput(isAnswered: .constant(true), response: .constant(LongAnswer(input: "This is an answer that may or may not be slightly long. In fact, when I think about it, it seems, however, to be rather decently long.")))
    }
}

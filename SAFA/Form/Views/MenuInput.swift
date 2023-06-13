//
//  MenuInput.swift
//  SAFA
//
//  Created by Mirai DTN on 6/13/23.
//

import SwiftUI

struct MenuInput: View {
    @Binding var isAnswered: Bool
    @Binding var response: MenuResponse
    
    var body: some View {
        Picker("", selection: $response.input) {
            ForEach(0 ..< response.options.count, id: \.self) { i in
                Text(response.options[i])
            }
        }
        .labelsHidden()
        .border(.red)
    }
}

struct MenuInput_Previews: PreviewProvider {
    static var previews: some View {
        MenuInput(isAnswered: .constant(true), response: .constant(MenuResponse(input: 2, options: ["Boston", "New York", "San Francisco"])))
    }
}

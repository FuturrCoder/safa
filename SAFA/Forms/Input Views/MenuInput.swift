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
    @State private var input: Int
    
    var body: some View {
        Picker("", selection: $input) {
            Text("")
                .tag(0)
            ForEach(1...response.options.count, id: \.self) { i in
                Text(response.options[i-1])
                    .tag(i)
            }
        }
        .labelsHidden()
        .onChange(of: input) { newValue in
            if newValue == 0 {
                isAnswered = false
            } else {
                isAnswered = true
                response.input = input - 1
            }
        }
    }
    
    init(isAnswered: Binding<Bool>, response: Binding<MenuResponse>) {
        self._isAnswered = isAnswered
        self._response = response
        self.input = response.input.wrappedValue
    }
}

struct MenuInput_Previews: PreviewProvider {
    static var previews: some View {
        MenuInput(isAnswered: .constant(true), response: .constant(MenuResponse(input: 2, options: ["Boston", "New York", "San Francisco"])))
    }
}

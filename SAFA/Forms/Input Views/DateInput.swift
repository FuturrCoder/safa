//
//  DateInput.swift
//  SAFA
//
//  Created by Mirai DTN on 6/13/23.
//

import SwiftUI

struct DateInput: View {
    @Binding var isAnswered: Bool
    @Binding var response: DateResponse
    
    var body: some View {
        DatePicker("", selection: $response.input, in: response.range, displayedComponents: [.date])
            .labelsHidden()
    }
}

struct DateInput_Previews: PreviewProvider {
    private static var f: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        return formatter
    }
    
    static var previews: some View {
        DateInput(isAnswered: .constant(true), response: .constant(DateResponse(input: f.date(from: "2006")!)))
    }
}

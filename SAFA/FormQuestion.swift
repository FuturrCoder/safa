//
//  FormQuestion.swift
//  SAFA
//
//  Created by Mirai DTN on 11/13/22.
//

import SwiftUI

struct FormQuestion: View {
    @Binding var item: FormItem
    var response: Binding<NumberResponse>? {
        $item.response as? Binding<NumberResponse>
    }
    
    var body: some View {
        Section {
            Text(item.prompt)
            switch item.responseType {
            case .number:
                
                TextField("", value: $response.input, format: .number)
            case .date:
                <#code#>
            case .menu:
                <#code#>
            case .shortAnswer:
                <#code#>
            case .longAnswer:
                <#code#>
            case .image:
                <#code#>
            case .video:
                <#code#>
            }
        }
    }
}

struct FormQuestion_Previews: PreviewProvider {
    static var previews: some View {
        FormQuestion(item: .constant(ApplicationForm.samplePersonal[0]))
    }
}

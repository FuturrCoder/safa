//
//  FormFieldInfo.swift
//  SAFA
//
//  Created by Mirai DTN on 7/14/23.
//

import SwiftUI

struct FormFieldInfo: View {
    var text: String
    var color: Color
    
    var body: some View {
        Text(text)
            .font(.caption)
            .foregroundStyle(color)
            .listRowSeparator(.hidden, edges: .top)
            .listRowInsets(EdgeInsets(top: -5, leading: 20, bottom: 5, trailing: 20))
    }
    
    init(_ text: String, color: Color = .secondary) {
        self.text = text
        self.color = color
    }
}

#Preview {
    FormFieldInfo("This is a caption", color: .red)
}

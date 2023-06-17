//
//  SectionWrapper.swift
//  SAFA
//
//  Created by Mirai DTN on 6/16/23.
//

import SwiftUI

struct SectionWrapper<Content>: View where Content : View {
    var prompt: String
    var content: Content
    @EnvironmentObject var footer: Footer
    
    public init(prompt: String, @ViewBuilder content: () -> Content) {
        self.prompt = prompt
        self.content = content()
    }
    
    var body: some View {
        Section {
            Text(prompt)
            content
        } footer: {
            Text(footer.text)
                .foregroundColor(footer.color)
        }
    }
}

struct SectionWrapper_Previews: PreviewProvider {
    static var previews: some View {
        List {
            SectionWrapper(prompt: "What's the answer?") {
                TextField("Type here", text: .constant(""))
            }
        }
        .environmentObject(Footer(text: "this is a footer", color: .green))
    }
}

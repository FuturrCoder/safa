//
//  SectionWrapper.swift
//  SAFA
//
//  Created by Mirai DTN on 6/16/23.
//

import SwiftUI

struct SectionWrapper<Content>: View where Content : View {
    var prompt: String
//    @State var inputView: Content
    var content: Content
    @EnvironmentObject var footer: Footer
    
    public init(prompt: String, @ViewBuilder content: () -> Content) {
        self.prompt = prompt
//        self._input = input
//        self._inputView = .init(initialValue: content())
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
        SectionWrapper(prompt: "What's the answer?") {
            TextField("Type here", text: .constant(""))
        }
        .environmentObject(Footer())
    }
}

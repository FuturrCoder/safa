//
//  SectionWrapper.swift
//  SAFA
//
//  Created by Mirai DTN on 6/16/23.
//

import SwiftUI

struct SectionWrapper<Content>: View where Content : View {
    var item: FormItem
    var content: Content
    @State private var tooltipShowing: Bool = false
    @EnvironmentObject var footer: Footer
    
    public init(item: FormItem, @ViewBuilder content: () -> Content) {
        self.item = item
        self.content = content()
    }
    
    var asterisk: AttributedString {
        var result = AttributedString(tooltipShowing ? "* Required" : "*        ")
        result.foregroundColor = item.isAnswered ? .secondary : .red
        result.link = URL(string: "https://google.com")
        return result
    }
    
    var body: some View {
        Section {
            HStack {
                Text(item.isRequired ? "\(item.prompt) \(asterisk)" : "\(item.prompt)")
                    .environment(\.openURL, OpenURLAction(handler: { _ in
                        if tooltipShowing { return .discarded }
                        withAnimation {
                            tooltipShowing = true
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation {
                                tooltipShowing = false
                            }
                        }
                        return .discarded
                    }))
            }
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
            SectionWrapper(item: ApplicationForm.motivations[0]) {
                TextField("Type here", text: .constant(""))
            }
        }
        .environmentObject(Footer(text: "this is a footer", color: .green))
    }
}

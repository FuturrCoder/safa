//
//  MenuInput.swift
//  SAFA
//
//  Created by Mirai DTN on 6/13/23.
//

import SwiftUI

struct MenuInput: View {
    @Binding var isAnswered: Bool
    @Binding var form: ApplicationForm
    @Binding var response: MenuResponse
    @State private var input: Int
    @State private var showingAlert: Bool = false
    
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
                response.input = newValue - 1
                if response.determinesPage {
                    if let pages = response.pages[response.input] {
                        form.setNextPages(to: pages)
                    } else {
                        showingAlert = true
                    }
                }
            }
        }
        .alert("Invalid Option", isPresented: $showingAlert) {
            Button("OK", role: .cancel) {
                input = 0
            }
        }
    }
    
    init(isAnswered: Binding<Bool>, form: Binding<ApplicationForm>, response: Binding<MenuResponse>) {
        self._isAnswered = isAnswered
        self._form = form
        self._response = response
        self._input = .init(initialValue: response.input.wrappedValue)
    }
}

struct MenuInput_Previews: PreviewProvider {
    static var previews: some View {
        MenuInput(isAnswered: .constant(true), form: .constant(ApplicationForm.sampleData[0]), response: .constant(MenuResponse(input: 2, options: ["Boston", "New York", "San Francisco"])))
    }
}

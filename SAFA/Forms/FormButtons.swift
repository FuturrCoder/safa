//
//  FormButtons.swift
//  SAFA
//
//  Created by Mirai DTN on 6/22/23.
//

import SwiftUI

struct FormButtons: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var form: ApplicationForm
    @Binding var current: Int
    @State private var maxWidth: CGFloat = .zero
    
    var body: some View {
        ZStack {
            Button("Submit") {
                hideKeyboard()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    form.submit()
                    presentationMode.wrappedValue.dismiss()
                }
            }
            .disabled(form.unanswered != 0 || form.completed)
            .buttonStyle(.borderedProminent)
            HStack {
                if form.hasPrev {
                    Button {
                        hideKeyboard()
                        current -= 1
                    } label: {
                        Text("Previous")
                            .background(widthReader($maxWidth))
                            .frame(minWidth: maxWidth)
                    }
                    .buttonStyle(.bordered)
                }
                Spacer()
                if form.hasNext {
                    Button {
                        hideKeyboard()
                        current += 1
                    } label: {
                        Text("Next")
                            .background(widthReader($maxWidth))
                            .frame(minWidth: maxWidth)
                    }
                    .buttonStyle(.bordered)
                }
            }
        }
    }
    
    private func widthReader(_ binding: Binding<CGFloat>) -> some View {
        GeometryReader { proxy in
            Color.clear
                .onAppear {
                    binding.wrappedValue = max(binding.wrappedValue, proxy.size.width)
                }
        }
    }
}

struct FormButtons_Previews: PreviewProvider {
    static var previews: some View {
        FormButtons(form: .constant(ApplicationForm.sampleData[0]), current: .constant(1))
    }
}

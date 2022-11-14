//
//  FormQuestion.swift
//  SAFA
//
//  Created by Mirai DTN on 11/13/22.
//

import SwiftUI
import Combine

struct FormQuestion: View {
    @Binding var item: FormItem
    @State var text: String
    @State var number: Int
    @State var date: Date
    
    var body: some View {
        Section {
            Text(item.prompt)
            switch item.response {
            case .number(let input, let range):
                TextField("", value: $number, format: .number)
                    .keyboardType(.numberPad)
                    .onChange(of: number) { newValue in
                        if !range.contains(newValue) {
                            number = newValue.clamped(to: range)
                        }
                        item.response = .number(number, range)
                    }
            case .date(let input, let range):
                DatePicker("", selection: $date, displayedComponents: [.date])
            case .menu(let input, let options):
                Picker("", selection: $number) {
                    ForEach(0 ..< options.count, id: \.self) { i in
                        Text(options[i])
                    }
                }
            case .shortAnswer(let input):
                TextField("", text: $text)
            case .longAnswer(let input):
                TextEditor(text: $text)
            case .image(let input):
                Image(systemName: "plus")
            case .video(let input):
                Image(systemName: "plus")
            }
        }
    }
    
    init(item: Binding<FormItem>) {
        self._item = item
        _text = .init(initialValue: "")
        _number = .init(initialValue: 0)
        _date = .init(initialValue: Date(timeIntervalSince1970: 0))
        switch item.wrappedValue.response {
        case .number(let input, _), .menu(let input, _):
            _number = .init(initialValue: input)
        case .date(let input, _):
            _date = .init(initialValue: input)
        case .shortAnswer(let input), .longAnswer(let input):
            _text = .init(initialValue: input)
        case .image(_), .video(_):
            break
        }
    }
}

struct FormQuestion_Previews: PreviewProvider {
    static var previews: some View {
        FormQuestion(item: .constant(ApplicationForm.samplePersonal[0]))
    }
}

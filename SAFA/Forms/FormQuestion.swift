//
//  FormQuestion.swift
//  SAFA
//
//  Created by Mirai DTN on 11/13/22.
//

import SwiftUI

struct FormQuestion: View {
    @Binding var item: FormItem
    @StateObject var footer: Footer = Footer()
//    @State private var input: String
//    @State var text: String
//    @State var number: Int
//    @State var date: Date
    
    var body: some View {
//        Section {
//            Text(item.prompt)
        SectionWrapper(item: item) {
            switch item.response {
            case is IntResponse:
                IntInput(isAnswered: $item.isAnswered,
                         response: .init(get: { item.response as! IntResponse },
                                         set: { item.response = $0 }))
            case is DateResponse:
                DateInput(isAnswered: $item.isAnswered,
                          response: .init(get: { item.response as! DateResponse },
                                          set: { item.response = $0 }))
            case is MenuResponse:
                MenuInput(isAnswered: $item.isAnswered,
                          response: .init(get: { item.response as! MenuResponse },
                                          set: { item.response = $0 }))
            case is ShortAnswer:
                ShortInput(isAnswered: $item.isAnswered,
                           response: .init(get: { item.response as! ShortAnswer },
                                           set: { item.response = $0 }))
            case is LongAnswer:
                LongInput(isAnswered: $item.isAnswered,
                          response: .init(get: { item.response as! LongAnswer },
                                          set: { item.response = $0 }))
            case is ImageResponse:
                ImageInput(isAnswered: $item.isAnswered,
                           response: .init(get: { item.response as! ImageResponse },
                                           set: { item.response = $0 }))
            case is VideoResponse:
                VideoInput(isAnswered: $item.isAnswered,
                           response: .init(get: { item.response as! VideoResponse },
                                           set: { item.response = $0 }))
            case is FileResponse:
                FileInput(isAnswered: $item.isAnswered,
                          response: .init(get: { item.response as! FileResponse },
                                          set: { item.response = $0 }))
            default:
                EmptyView()
            }
        }
        .environmentObject(footer)
            /*switch item.response {
            case .number(_, let range):
                TextField("", value: $number, format: .number)
                    .keyboardType(.numberPad)
                    .onChange(of: number) { newValue in
                        if !range.contains(newValue) {
                            number = newValue.clamped(to: range)
                        }
                        item.response = .number(number, range)
                    }
            case .date(_, let range):
                DatePicker("", selection: $date, in: range, displayedComponents: [.date])
                    .onChange(of: date) { newValue in
                        if !range.contains(newValue) {
                            date = newValue.clamped(to: range)
                        }
                        item.response = .date(date, range)
                    }
            case .menu(_, let options):
                Picker("", selection: $number) {
                    ForEach(0 ..< options.count, id: \.self) { i in
                        Text(options[i])
                    }
                }
                .onChange(of: number) { newValue in
                    item.response = .menu(newValue, options)
                }
            case .shortAnswer(_):
                TextField("", text: $text)
                    .onChange(of: text) { newValue in
                        item.response = .shortAnswer(newValue)
                    }
            case .longAnswer(_):
                TextEditor(text: $text)
                    .onChange(of: text) { newValue in
                        item.response = .longAnswer(newValue)
                    }
            case .image(_):
                Image(systemName: "plus")
            case .video(_):
                Image(systemName: "plus")
            }*/
//        }
    }
    
//    init(item: Binding<FormItem>) {
//        self._item = item
//        self.input = ""
//    }
    
//    init(item: Binding<FormItem>) {
//        self._item = item
//        _text = .init(initialValue: "")
//        _number = .init(initialValue: 0)
//        _date = .init(initialValue: Date(timeIntervalSince1970: 0))
//        switch item.wrappedValue.response {
//        case .number(let input, _), .menu(let input, _):
//            _number = .init(initialValue: input)
//        case .date(let input, _):
//            _date = .init(initialValue: input)
//        case .shortAnswer(let input), .longAnswer(let input):
//            _text = .init(initialValue: input)
//        case .image(_), .video(_):
//            break
//        }
//    }
}

class Footer: ObservableObject {
    @Published var text: String
    @Published var color: Color
    
    init(text: String = "", color: Color = .secondary) {
        self.text = text
        self.color = color
    }
}

struct FormQuestion_Previews: PreviewProvider {
    static var previews: some View {
        FormQuestion(item: .constant(ApplicationForm.motivations[0]))
    }
}

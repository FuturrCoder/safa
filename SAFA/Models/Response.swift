//
//  Response.swift
//  SAFA
//
//  Created by Mirai DTN on 11/13/22.
//

/*import SwiftUI
import Combine

enum ResponseType: Codable {
    case number
    case date
    case menu
    case shortAnswer
    case longAnswer
    case image
    case video
    
    func type() -> any Response.Type {
        switch self {
        case .number:
            return NumberResponse.self
        case .date:
            return DateResponse.self
        case .menu:
            return MenuResponse.self
        case .shortAnswer:
            return ShortAnswer.self
        case .longAnswer:
            return LongAnswer.self
        case .image:
            return ImageResponse.self
        case .video:
            return VideoResponse.self
        }
    }
}

protocol Response: Codable {
    associatedtype InputType
    
    var input: InputType { get set }
    
    func responseType() -> ResponseType
    mutating func field() -> any View
}

extension Response {
    mutating func inputBinding() -> Binding<InputType> {
        Binding(get: { self.input }, set: { self.input = $0 })
    }
}

struct NumberResponse: Response {
    func responseType() -> ResponseType { .number }
    var input: Int = 0
    let range: ClosedRange<Int>
    
    mutating func field() -> any View {
        TextField("", value: inputBinding(), format: .number)
    }
}
struct DateResponse: Response {
    func responseType() -> ResponseType { .date }
    var input: Date = Date(timeIntervalSince1970: 0)
    let range: DateInterval
    
    mutating func field() -> any View {
        DatePicker("", selection: inputBinding(), displayedComponents: [.date])
    }
}
struct MenuResponse: Response {
    func responseType() -> ResponseType { .menu }
    /// Index of currently selected option
    var input: Int = 0
    let options: [String]
    
    mutating func field() -> any View {
        Picker("", selection: inputBinding()) {
            ForEach(0 ..< options.count, id: \.self) { i in
                Text(options[i])
            }
        }
    }
}
struct ShortAnswer: Response {
    func responseType() -> ResponseType { .shortAnswer }
    var input: String = ""
    
    mutating func field() -> any View {
        TextField("", text: inputBinding())
    }
}
struct LongAnswer: Response {
    func responseType() -> ResponseType { .longAnswer }
    var input: String = ""
    
    mutating func field() -> any View {
        TextEditor(text: inputBinding())
    }
}
struct ImageResponse: Response {
    func responseType() -> ResponseType { .image }
    var input: URL?
    
    mutating func field() -> any View {
        Button(action: {}) {
            Image(systemName: "plus")
        }
    }
}
struct VideoResponse: Response {
    func responseType() -> ResponseType { .video }
    var input: URL?
    
    mutating func field() -> any View {
        Button(action: {}) {
            Image(systemName: "plus")
        }
    }
}*/

//
//  Response.swift
//  SAFA
//
//  Created by Mirai DTN on 11/13/22.
//

import Foundation

enum Response: Codable {
    case number(Int, ClosedRange<Int>)
    case date(Date, ClosedRange<Date>)
    /// Currently selected, list of options
    case menu(Int, [String])
    case shortAnswer(String)
    case longAnswer(String)
    case image(URL?)
    case video(URL?)
    
    struct ArgumentError: Error {}
    
    /*mutating func inputHandler() -> ((inout Response) -> ()) {
        switch self {
        case .number(_, let range):
            return { newValue in
                guard case let .number(newInput, _) = newValue else { newValue = .number(0, range); return }
                if !range.contains(newInput) {
                    newValue.constrain()
                }
                if case let .number(i, _) = newValue {
                    self = .number(i, range)
                }
            }
        case .date(_, let range):
            return { newValue in
                guard case let .date(newInput, _) = newValue else { newValue = .date(Date(), range); return }
                if !range.contains(newInput) {
                    newValue.constrain()
                }
                if case let .date(i, _) = newValue {
                    self = .date(i, range)
                }
            }
        case .menu(_, let options):
            return { newValue in
                guard case let .menu(newInput, _) = newValue else { newValue = .menu(0, options); return }
                self = .menu(newInput, options)
            }
        case .shortAnswer(_):
            return { newValue in
                guard case let .shortAnswer(newInput) = newValue else { newValue = .shortAnswer(""); return }
                self = .shortAnswer(newInput)
            }
        case .longAnswer(_):
            return { newValue in
                guard case let .longAnswer(newInput) = newValue else { newValue = .longAnswer(""); return }
                self = .longAnswer(newInput)
            }
        case .image(_):
            return { newValue in
                guard case let .image(newInput) = newValue else { newValue = .image(nil); return }
                self = .image(newInput)
            }
        case .video(_):
            return { newValue in
                guard case let .video(newInput) = newValue else { newValue = .video(nil); return }
                self = .video(newInput)
            }
        }
    }
    
    mutating func constrain() {
        switch self {
        case .number(let input, let range):
            self = .number(input.clamped(to: range), range)
        case .date(let input, let range):
            self = .date(input.clamped(to: range), range)
        default:
            return
        }
    }*/
}

extension Comparable {
    func clamped(to range: ClosedRange<Self>) -> Self {
        return min(max(self, range.lowerBound), range.upperBound)
    }
}

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

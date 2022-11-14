//
//  Response.swift
//  SAFA
//
//  Created by Mirai DTN on 11/13/22.
//

import SwiftUI

enum ResponseType: Codable {
    case number
    case date
    case menu
    case shortAnswer
    case longAnswer
    case image
    case video
    
    func type() -> Response.Type {
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
    func responseType() -> ResponseType
}

struct NumberResponse: Response {
    func responseType() -> ResponseType { .number }
    var input: Int = 0
    let range: ClosedRange<Int>
}
struct DateResponse: Response {
    func responseType() -> ResponseType { .date }
    var input: Date = Date(timeIntervalSince1970: 0)
    let range: DateInterval
}
struct MenuResponse: Response {
    func responseType() -> ResponseType { .menu }
    /// Index of currently selected option
    var index: Int = 0
    let options: [String]
}
struct ShortAnswer: Response {
    func responseType() -> ResponseType { .shortAnswer }
    var input: String = ""
}
struct LongAnswer: Response {
    func responseType() -> ResponseType { .longAnswer }
    var input: String = ""
}
struct ImageResponse: Response {
    func responseType() -> ResponseType { .image }
    var input: URL?
}
struct VideoResponse: Response {
    func responseType() -> ResponseType { .video }
    var input: URL?
}

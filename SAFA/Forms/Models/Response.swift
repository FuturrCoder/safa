//
//  Response.swift
//  SAFA
//
//  Created by Mirai DTN on 11/13/22.
//

import Foundation
import UniformTypeIdentifiers
import SwiftUI

enum ResponseKeys: String, CodingKey, Codable {
    case int
    case date
    case menu
    case shortAnswer
    case longAnswer
    case image
    case video
    case file
}

protocol Response: Codable, Equatable {
    var str: String { get }
    
    /// encode self in the given container
    func encodeNested(container: inout KeyedEncodingContainer<ResponseKeys>) throws
    /// decode from the given container
    init(from container: KeyedDecodingContainer<ResponseKeys>) throws
}

protocol BaseResponse: Response {
    associatedtype T: Codable, CustomStringConvertible
    var input: T { get set }
    static var type: ResponseKeys { get }
    init(input: T)
}

enum BaseKeys: String, CodingKey {
    case input
}

extension BaseResponse {
    var str: String { input.description }
    
    func encodeNested(container: inout KeyedEncodingContainer<ResponseKeys>) throws {
        var nested = container.nestedContainer(keyedBy: BaseKeys.self, forKey: Self.type)
        try nested.encode(input, forKey: .input)
    }
    
    init(from container: KeyedDecodingContainer<ResponseKeys>) throws {
        let nested = try container.nestedContainer(keyedBy: BaseKeys.self, forKey: Self.type)
        self.init(input: try nested.decode(T.self, forKey: .input))
//        self.input = try nested.decode(T.self, forKey: .input)
    }
}

protocol RangedResponse: Response {
    associatedtype T: Codable, CustomStringConvertible
    associatedtype U: Codable & Comparable
    var input: T { get set }
    var range: ClosedRange<U> { get }
    static var type: ResponseKeys { get }
    init(input: T, range: ClosedRange<U>)
}

enum RangedKeys: String, CodingKey {
    case input
    case range
}

extension RangedResponse {
    var str: String { input.description }
    
    func encodeNested(container: inout KeyedEncodingContainer<ResponseKeys>) throws {
        var nested = container.nestedContainer(keyedBy: RangedKeys.self, forKey: Self.type)
        try nested.encode(input, forKey: .input)
        try nested.encode(range, forKey: .range)
    }
    
    init(from container: KeyedDecodingContainer<ResponseKeys>) throws {
        let nested = try container.nestedContainer(keyedBy: RangedKeys.self, forKey: Self.type)
        self.init(input: try nested.decode(T.self, forKey: .input),
                  range: try nested.decode(ClosedRange<U>.self, forKey: .range))
    }
}

struct IntResponse: RangedResponse {
    var input: Int = 0
    let range: ClosedRange<Int>
    static let type: ResponseKeys = .int
}

struct DateResponse: RangedResponse {
    var input: Date
    let range: ClosedRange<Date>
    static let type: ResponseKeys = .date
    
    init(input: Date = Date(), range: ClosedRange<Date> = Date(timeIntervalSince1970: -2208988800)...Date()) {
        self.input = input
        self.range = range
    }
}

struct MenuResponse: Response {
    /// Index of currently selected option
    var input: Int
    var str: String { input.description }
    let options: [String]
    /// does the choice affect the next pages?
    let determinesPage: Bool
    /// option selected --> next pages
    let pages: [Int: [Int]]
    static let type: ResponseKeys = .menu
    
    init(input: Int = 0, options: [String], determinesPage: Bool = false, pages: [Int : [Int]] = [:]) {
        self.input = input
        self.options = options
        self.determinesPage = determinesPage
        self.pages = pages
    }
}

struct ShortAnswer: RangedResponse {
    var input: String
    /// range for number of characters
    let range: ClosedRange<Int>
    static let type: ResponseKeys = .shortAnswer
    
    init(input: String = "", range: ClosedRange<Int> = 1...100) {
        self.input = input
        self.range = range
    }
}

struct LongAnswer: RangedResponse {
    var input: String
    /// range for number of characters
    let range: ClosedRange<Int>
    static let type: ResponseKeys = .longAnswer
    
    init(input: String = "", range: ClosedRange<Int> = 1...2000) {
        self.input = input
        self.range = range
    }
}

struct ImageResponse: BaseResponse {
    var input: URL?
    static let type: ResponseKeys = .image
}

struct VideoResponse: BaseResponse {
    var input: URL?
    static let type: ResponseKeys = .video
}

struct FileResponse: Response {
    var input: URL?
    var str: String { input.description }
    let type: Set<UTType>
    static let defaultTypes: Set<UTType> = [.pdf, .plainText, .rtf,
                                            UTType(filenameExtension: "doc")!,
                                            UTType(filenameExtension: "docx")!]
    
    init(input: URL? = nil, type: Set<UTType> = defaultTypes) {
        self.input = input
        self.type = type
    }
}

extension URL?: CustomStringConvertible {
    public var description: String { self?.description ?? "" }
}

extension MenuResponse {
    func encodeNested(container: inout KeyedEncodingContainer<ResponseKeys>) throws {
        var nested = container.nestedContainer(keyedBy: CodingKeys.self, forKey: .menu)
        try nested.encode(input, forKey: .input)
        try nested.encode(options, forKey: .options)
        try nested.encode(determinesPage, forKey: .determinesPage)
        try nested.encode(pages, forKey: .pages)
    }
    
    init(from container: KeyedDecodingContainer<ResponseKeys>) throws {
        let nested = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .menu)
        input = try nested.decode(Int.self, forKey: .input)
        options = try nested.decode([String].self, forKey: .options)
        determinesPage = try nested.decode(Bool.self, forKey: .determinesPage)
        pages = try nested.decode([Int: [Int]].self, forKey: .pages)
    }
}

extension FileResponse {
    func encodeNested(container: inout KeyedEncodingContainer<ResponseKeys>) throws {
        var nested = container.nestedContainer(keyedBy: CodingKeys.self, forKey: .file)
        try nested.encode(input, forKey: .input)
        try nested.encode(type, forKey: .type)
    }
    
    init(from container: KeyedDecodingContainer<ResponseKeys>) throws {
        let nested = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .file)
        input = try nested.decode(URL?.self, forKey: .input)
        type = try nested.decode(Set<UTType>.self, forKey: .type)
    }
}

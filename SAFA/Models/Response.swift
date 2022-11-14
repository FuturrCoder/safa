//
//  Response.swift
//  SAFA
//
//  Created by Mirai DTN on 11/13/22.
//

import Foundation

protocol Response: Codable {
    func decode<T>(container: KeyedDecodingContainer<T>, forKey: KeyedDecodingContainer<T>.Key) throws -> Response
}

struct NumberResponse: Response {
    var input: Int = 0
    let range: ClosedRange<Int>
    
    func decode<T>(container: KeyedDecodingContainer<T>, forKey: KeyedDecodingContainer<T>.Key) throws -> Response {
        return try container.decode(NumberResponse.self, forKey: forKey)
    }
}
struct DateResponse: Response {
    var input: Date = Date(timeIntervalSince1970: 0)
    let range: DateInterval
    
    func decode<T>(container: KeyedDecodingContainer<T>, forKey: KeyedDecodingContainer<T>.Key) throws -> Response {
        return try container.decode(DateResponse.self, forKey: forKey)
    }
}
struct MenuResponse: Response {
    /// Index of currently selected option
    var index: Int = 0
    let options: [String]
    
    func decode<T>(container: KeyedDecodingContainer<T>, forKey: KeyedDecodingContainer<T>.Key) throws -> Response {
        return try container.decode(MenuResponse.self, forKey: forKey)
    }
}
struct ShortAnswer: Response {
    var input: String = ""
    
    func decode<T>(container: KeyedDecodingContainer<T>, forKey: KeyedDecodingContainer<T>.Key) throws -> Response {
        return try container.decode(ShortAnswer.self, forKey: forKey)
    }
}
struct LongAnswer: Response {
    var input: String = ""
    
    func decode<T>(container: KeyedDecodingContainer<T>, forKey: KeyedDecodingContainer<T>.Key) throws -> Response {
        return try container.decode(LongAnswer.self, forKey: forKey)
    }
}
struct ImageResponse: Response {
    var input: URL?
    
    func decode<T>(container: KeyedDecodingContainer<T>, forKey: KeyedDecodingContainer<T>.Key) throws -> Response {
        return try container.decode(ImageResponse.self, forKey: forKey)
    }
}
struct VideoResponse: Response {
    var input: URL?
    
    func decode<T>(container: KeyedDecodingContainer<T>, forKey: KeyedDecodingContainer<T>.Key) throws -> Response {
        return try container.decode(VideoResponse.self, forKey: forKey)
    }
}

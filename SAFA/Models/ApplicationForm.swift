//
//  ApplicationForm.swift
//  SAFA
//
//  Created by Mirai DTN on 11/13/22.
//

import Foundation

struct ApplicationForm: Identifiable, Codable {
    let id: UUID
    let title: String
    let icon: String
    var items: [FormItem]
    
    init(id: UUID = UUID(), title: String, icon: String, items: [FormItem]) {
        self.id = id
        self.title = title
        self.icon = icon
        self.items = items
    }
}

struct FormItem: Identifiable {
    let id: UUID
    let prompt: String
    let responseType: ResponseType
    var response: Response
    let isOptional: Bool
    /// Whether the question has been answered
    var isAnswered: Bool
    
    init(id: UUID = UUID(), prompt: String, response: Response, optional: Bool = false, answered: Bool = true) {
        self.id = id
        self.prompt = prompt
        self.responseType = response.responseType()
        self.response = response
        self.isOptional = optional
        self.isAnswered = answered
    }
}

extension FormItem: Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case prompt
        case responseType
        case response
        case isOptional
        case isAnswered
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        prompt = try container.decode(String.self, forKey: .prompt)
        responseType = try container.decode(ResponseType.self, forKey: .responseType)
        response = try container.decode(responseType.type(), forKey: .response)
        isOptional = try container.decode(Bool.self, forKey: .isOptional)
        isAnswered = try container.decode(Bool.self, forKey: .isAnswered)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(prompt, forKey: .prompt)
        try container.encode(responseType, forKey: .responseType)
        try container.encode(response, forKey: .response)
        try container.encode(isOptional, forKey: .isOptional)
        try container.encode(isAnswered, forKey: .isAnswered)
    }
}

extension ApplicationForm {
    private static var f: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        return formatter
    }
    static let samplePersonal: [FormItem] = [
        FormItem(prompt: "What is your legal name?", response: ShortAnswer()),
        FormItem(prompt: "What is your preferred nickname?", response: ShortAnswer(), optional: true),
        FormItem(prompt: "What is your gender?", response: MenuResponse(options: ["Male", "Female", "Other/Non-binary"])),
        FormItem(prompt: "What is your date of birth?",
                 response: DateResponse(range: DateInterval(start: f.date(from: "1900")!, end: Date()))),
        FormItem(prompt: "Upload a profile photo", response: ImageResponse())
    ]
    static let sampleVideos: [FormItem] = [
        FormItem(prompt: "Upload a video of your dribbling", response: VideoResponse()),
        FormItem(prompt: "Upload a video of your penalty kick", response: VideoResponse())
    ]
    static let samplePreference: [FormItem] = [
        FormItem(prompt: "About how many years have you been playing football for?", response: NumberResponse(range: 0...100)),
        FormItem(prompt: "Why do you want to go to a football academy?", response: LongAnswer()),
        FormItem(prompt: "What do you look for in a football academy?", response: LongAnswer()),
        FormItem(prompt: "What is one of your greatest accomplishments?", response: LongAnswer())
    ]
    static let sampleData: [ApplicationForm] = [
        ApplicationForm(title: "Personal", icon: "person", items: samplePersonal),
        ApplicationForm(title: "Videos", icon: "play.rectangle", items: sampleVideos),
        ApplicationForm(title: "Skill Level", icon: "soccerball", items: samplePreference)
    ]
}

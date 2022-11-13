//
//  ApplicationForm.swift
//  SAFA
//
//  Created by Mirai DTN on 11/13/22.
//

import Foundation

struct ApplicationForm: Identifiable, Codable {
    let id: UUID
    var items: [FormItem]
    
    init(id: UUID = UUID(), items: [FormItem]) {
        self.id = id
        self.items = items
    }
}

struct FormItem: Identifiable, Codable {
    let id: UUID
    let prompt: String
    var response: Response
    let optional: Bool
    /// Whether the question has been answered
    var answered: Bool
    
    init(id: UUID = UUID(), prompt: String, response: Response, optional: Bool = false, answered: Bool = true) {
        self.id = id
        self.prompt = prompt
        self.response = response
        self.optional = optional
        self.answered = answered
    }
}

extension FormItem {
    enum Response: Codable {
        case number(Int, ClosedRange<Int>)
        case date(Date, DateInterval)
        /// Currently selected, list of options
        case menu(Int, [String])
        case shortAnswer(String)
        case longAnswer(String)
        case image(URL?)
        case video(URL?)
    }
}

extension ApplicationForm {
    private static var f: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        return formatter
    }
    static let samplePersonal: [FormItem] = [
        FormItem(prompt: "What is your legal name?", response: .shortAnswer("")),
        FormItem(prompt: "What is your preferred nickname?", response: .shortAnswer(""), optional: true),
        FormItem(prompt: "What is your gender?", response: .menu(0, ["Male", "Female", "Other/Non-binary"])),
        FormItem(prompt: "What is your date of birth?",
                 response: .date(f.date(from: "1970")!, DateInterval(start: f.date(from: "1900")!, end: Date()))),
        FormItem(prompt: "Upload a profile photo", response: .image(nil))
    ]
    static let sampleVideos: [FormItem] = [
        FormItem(prompt: "Upload a video of your dribbling", response: .video(nil)),
        FormItem(prompt: "Upload a video of your penalty kick", response: .video(nil))
    ]
    static let samplePreference: [FormItem] = [
        FormItem(prompt: "About how many years have you been playing football for?", response: .number(0, 0...100)),
        FormItem(prompt: "Why do you want to go to a football academy?", response: .longAnswer("")),
        FormItem(prompt: "What do you look for in a football academy?", response: .longAnswer("")),
        FormItem(prompt: "What is one of your greatest accomplishments?", response: .longAnswer(""))
    ]
    static let sampleData: [ApplicationForm] = [
        ApplicationForm(items: samplePersonal),
        ApplicationForm(items: sampleVideos),
        ApplicationForm(items: samplePreference)
    ]
}

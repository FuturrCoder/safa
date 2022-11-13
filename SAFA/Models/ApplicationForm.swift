//
//  ApplicationForm.swift
//  SAFA
//
//  Created by Mirai DTN on 11/13/22.
//

import Foundation

struct ApplicationForm: Identifiable, Codable {
    let id: UUID
    var questions: [FormItem]
    
    init(id: UUID = UUID(), questions: [FormItem]) {
        self.id = id
        self.questions = questions
    }
}

struct FormItem: Identifiable, Codable {
    let id: UUID
    let prompt: String
    var response: Response
}

extension FormItem {
    enum Response: Codable {
        case number(Int)
        case date(Date)
        case shortAnswer(String)
        case longAnswer(String)
        case image(URL)
        case video(URL)
    }
}

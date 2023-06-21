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
    var pages: [FormPage]
    /// first is current index
//    var previousIndices: IntStack
//    var nextIndices: IntStack
//    var current: Int { previousIndices.first! }
    /// list of page indices
    var indices: [Int]
    /// index of current page in `indices`
    var current: Int
//    var currentPage: FormPage { pages[indices[current]] }
    var answered: Int { indices.reduce(0) { $0 + pages[$1].answered } }
    var unanswered: Int {
//        pages[current].unanswered + nextIndices.storage.reduce(0) { $0 + pages[$1].unanswered }
        indices.reduce(0) { $0 + pages[$1].unanswered }
    }
    var progress: Float { Float(answered) / Float(answered + unanswered) }
//    var canContinue: Bool { pages[current].unanswered == 0 && nextIndices.first != nil }
//    var canContinue: Bool { current != indices.count - 1 && currentPage.unanswered == 0 }
    /// list of indices for pages that can be viewed, in ascending order
    var viewable: [Int] {
//        if canContinue {
//            return previousIndices.storage + [nextIndices.first!]
//        } else {
//            return previousIndices.storage
//        }
        var result: [Int] = []
        for i in indices {
            if pages[i].unanswered == 0 {
                result.append(i)
            } else {
                result.append(i)
                break
            }
        }
        return result
    }
    
    init(id: UUID = UUID(), title: String, icon: String, pages: [FormPage]) {
        self.id = id
        self.title = title
        self.icon = icon
        self.pages = pages
//        self.previousIndices = IntStack(from: [0])
//        self.nextIndices = IntStack(from: Array(1..<pages.count))
        self.current = 0
        self.indices = Array(0..<pages.count)
    }
    
    mutating func nextPage() {
//        guard let i = nextIndices.pop() else { return }
//        previousIndices.push(i)
        if current != indices.count - 1 {
            current += 1
        }
    }
    
    mutating func prevPage() {
//        guard let i = previousIndices.pop() else { return }
//        nextIndices.push(i)
        if current != 0 {
            current -= 1
        }
    }
    
    /// set `current` to i
    mutating func setPage(to i: Int) { current = i }
    
    mutating func setNextPages(to next: [Int]) {
//        nextIndices = IntStack(from: indices)
        indices = indices[...current] + next
    }
    
//    enum CodingKeys: CodingKey {
//        case title
//        case icon
//        case pages
////        case current
//    }
    
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: ApplicationForm.CodingKeys.self)
//        self.id = UUID()
//        self.title = try container.decode(String.self, forKey: ApplicationForm.CodingKeys.title)
//        self.icon = try container.decode(String.self, forKey: ApplicationForm.CodingKeys.icon)
//        self.pages = try container.decode([FormPage].self, forKey: ApplicationForm.CodingKeys.pages)
////        self.current = try container.decode(Int.self, forKey: ApplicationForm.CodingKeys.current)
//    }
}

struct FormPage: Identifiable, Codable {
    let id: UUID
    let description: String
    var items: [FormItem]
    var answered: Int { items.reduce(0) { $1.isAnswered ? $0 + 1 : $0 } }
    /// required but unanswered
    var unanswered: Int { items.reduce(0) { $1.isRequired && !$1.isAnswered ? $0 + 1 : $0 } }
    
    init(id: UUID = UUID(), description: String = "", items: [FormItem]) {
        self.id = id
        self.description = description
        self.items = items
    }
    
    enum CodingKeys: CodingKey {
        case description
        case items
    }
    
    init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer = try decoder.container(keyedBy: FormPage.CodingKeys.self)
        self.id = UUID()
        self.description = try container.decode(String.self, forKey: FormPage.CodingKeys.description)
        self.items = try container.decode([FormItem].self, forKey: FormPage.CodingKeys.items)
    }
}

struct FormItem: Identifiable {
    let id: UUID
    let prompt: String
    var response: any Response
    let isRequired: Bool
    var isAnswered: Bool /// Whether the question has been answered
    
    init(id: UUID = UUID(), prompt: String, response: any Response, required: Bool = true, isAnswered: Bool = false) {
        self.id = id
        self.prompt = prompt
        self.response = response
        self.isRequired = required
        self.isAnswered = isAnswered
    }
}

extension FormItem: Codable {
    enum CodingKeys: String, CodingKey {
        case prompt
        case required
        case isAnswered
        case response
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = UUID()
        prompt = try container.decode(String.self, forKey: .prompt)
        isRequired = try container.decode(Bool.self, forKey: .required)
        isAnswered = try container.decode(Bool.self, forKey: .isAnswered)
        let responseContainer = try container.nestedContainer(keyedBy: ResponseKeys.self, forKey: .response)
        if responseContainer.allKeys.count != 1 {
            let context = DecodingError.Context(
                codingPath: responseContainer.codingPath,
                debugDescription: "Invalid number of keys found, expected one.")
            throw DecodingError.dataCorrupted(context)
        }
        
        switch responseContainer.allKeys.first.unsafelyUnwrapped {
        case .int:
            response = try IntResponse(from: responseContainer)
        case .date:
            response = try DateResponse(from: responseContainer)
        case .menu:
            response = try MenuResponse(from: responseContainer)
        case .shortAnswer:
            response = try ShortAnswer(from: responseContainer)
        case .longAnswer:
            response = try LongAnswer(from: responseContainer)
        case .image:
            response = try ImageResponse(from: responseContainer)
        case .video:
            response = try VideoResponse(from: responseContainer)
        case .file:
            response = try FileResponse(from: responseContainer)
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        var responseContainer = container.nestedContainer(keyedBy: ResponseKeys.self, forKey: .response)
        try response.encodeNested(container: &responseContainer)
    }
}



extension ApplicationForm {
    private static var f: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        return formatter
    }
    
    static let videos = [
        FormItem(prompt: "What position are you?", response: MenuResponse(
            options: ["Goalkeeper", "Defender", "Midfielder", "Attacker"], determinesPage: true,
            pages: [0: [1, 2, 3, 4], 1: [5, 6, 7, 8], 2: [9, 10, 11, 12], 3: [13, 14, 15, 16, 17]])),
        FormItem(prompt: "Post a video of your shot-stopping", response: VideoResponse()),
        FormItem(prompt: "Post a video of a goal kick", response: VideoResponse()),
        FormItem(prompt: "Post a video of you catching the ball", response: VideoResponse()),
        FormItem(prompt: "Any additional highlights", response: VideoResponse(), required: false),
        FormItem(prompt: "Post a video of your tackling", response: VideoResponse()),
        FormItem(prompt: "Post a video of your clearing", response: VideoResponse()),
        FormItem(prompt: "Post a video of your jockeying", response: VideoResponse()),
        FormItem(prompt: "Any additional highlights", response: VideoResponse(), required: false),
        FormItem(prompt: "Post a video of your dribbling", response: VideoResponse()),
        FormItem(prompt: "Post a video of your passing", response: VideoResponse()),
        FormItem(prompt: "Post a video of your long shooting", response: VideoResponse()),
        FormItem(prompt: "Any additional highlights", response: VideoResponse(), required: false),
        FormItem(prompt: "Post a video of your shooting", response: VideoResponse()),
        FormItem(prompt: "Post a video of your 1v1", response: VideoResponse()),
        FormItem(prompt: "Post a video of your heading", response: VideoResponse()),
        FormItem(prompt: "Post a video of your dribbling", response: VideoResponse()),
        FormItem(prompt: "Any additional highlights", response: VideoResponse(), required: false)
    ]
    static let motivations = [
        FormItem(prompt: "What makes you passionate about soccer?", response: LongAnswer(range: 50...2000)),
        FormItem(prompt: "What is the highest level you have played soccer at?", response: LongAnswer(range: 1...1000)),
        FormItem(prompt: "What are your goals in the future for the beautiful game?", response: LongAnswer()),
        FormItem(prompt: "Tell us a soccer story in your life (be creative!)", response: LongAnswer()),
        FormItem(prompt: "What are you looking for in academies?", response: LongAnswer())
    ]
    static let personal = [
        FormItem(prompt: "How old are you?", response: IntResponse(range: 1...50)),
        FormItem(prompt: "When is your birthday?", response: DateResponse(range: f.date(from: "1960")!...Date())),
        FormItem(prompt: "How is your family’s financial situation?", response: LongAnswer(), required: false),
        FormItem(prompt: "How are you doing at school?", response: LongAnswer(), required: false),
        FormItem(prompt: "Are you able to drive/Do you have access to public transport?",
                 response: ShortAnswer(), required: false),
        FormItem(prompt: "Add your transcript (attachment)", response: FileResponse(), required: false),
        FormItem(prompt: "What are some of your extracurriculars?", response: LongAnswer(), required: false),
    ]
    static let description = "For each video section, you can upload each skill separately, or together on additional highlights"
    static let sampleData: [ApplicationForm] = [
        ApplicationForm(title: "Videos and uploads", icon: "play.rectangle",
                        pages: videos.map { FormPage(items: [$0]) }),
        ApplicationForm(title: "Motivations and Goals", icon: "target", pages: [FormPage(items: motivations)]),
        ApplicationForm(title: "Personal Information", icon: "person",
                        pages: [FormPage(description: "This form is optional", items: personal)])
    ]
}

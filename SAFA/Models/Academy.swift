//
//  Academy.swift
//  SAFA
//
//  Created by Mirai DTN on 11/14/22.
//

import Foundation

struct Academy: Codable, Identifiable {
    let id: UUID
    let name: String
    let description: String
    let icon: String
    var isFollowed: Bool
    let updates: [Update]
    
    init(id: UUID = UUID(), name: String, description: String, icon: String = "photo.fill", isFollowed: Bool = false, updates: [Update] = []) {
        self.id = id
        self.name = name
        self.description = description
        self.icon = icon
        self.isFollowed = isFollowed
        self.updates = updates
    }
}

extension Academy {
    struct Update: Codable, Identifiable {
        let id: UUID
        let title: String
        let body: String
        let icon: String
        
        init(id: UUID = UUID(), title: String, body: String, icon: String = "photo") {
            self.id = id
            self.title = title
            self.body = body
            self.icon = icon
        }
    }
}

extension Academy {
    static let sample1 = Academy(name: "Academy 1", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Tristique senectus et netus et malesuada.",
                                 updates: [
                                    Update(title: "Visit the academy", body: "Arcu non odio euismod lacinia at quis risus sed vulputate. Nec feugiat in fermentum posuere urna nec tincidunt praesent semper. Vitae et leo duis ut diam quam nulla. Bibendum ut tristique et egestas quis ipsum suspendisse ultrices. Pellentesque habitant morbi tristique senectus.", icon: "house"),
                                    Update(title: "Application is open!", body: "Risus commodo viverra maecenas accumsan lacus. Cras semper auctor neque vitae. Mi ipsum faucibus vitae aliquet nec. Eget felis eget nunc lobortis mattis aliquam faucibus purus in.", icon: "doc.text")
                                 ])
    static let sample2 = Academy(name: "Academy 2", description: "Sit amet mauris commodo quis imperdiet massa tincidunt nunc pulvinar. Eros in cursus turpis massa tincidunt dui ut ornare lectus. Gravida arcu ac tortor dignissim convallis aenean et tortor at. A erat nam at lectus urna duis convallis convallis.")
    static let sample3 = Academy(name: "Academy 3", description: "At tellus at urna condimentum mattis pellentesque id. Vitae nunc sed velit dignissim sodales ut.")
    static let sampleData: [Academy] = [sample1, sample2, sample3]
}

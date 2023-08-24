//
//  ProfileStore.swift
//  SAFA
//
//  Created by Mirai DTN on 6/13/23.
//

import Foundation

struct Profile {
    var firstName: String
    var lastName: String
    var email: String
    var birthday: Date
    
    init(firstName: String = "", lastName: String = "", email: String = "", birthday: Date = Date()) {
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.birthday = birthday
    }
}

extension Profile {
    static let sample = Profile(firstName: "Mirai", lastName: "Nishioka", email: "mnishioka@commschool.org", birthday: Date(timeIntervalSince1970: 1136091600))
}

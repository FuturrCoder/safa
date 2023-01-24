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
    let location: String
    let website: String
    let email: String?
    let phoneNumber: String?
    let ages: String
    let tuition: String?
    let description: String
    let icon: String
    var isFollowed: Bool
    let updates: [Update]
    
    init(id: UUID = UUID(), name: String, location: String, website: String, email: String? = nil, phoneNumber: String? = nil, ages: String, tuition: String, description: String, icon: String, isFollowed: Bool = false, updates: [Update] = []) {
        self.id = id
        self.name = name
        self.location = location
        self.website = website
        self.email = email
        self.phoneNumber = phoneNumber
        self.ages = ages
        self.tuition = tuition
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
    static let sample1 = Academy(name: "NEFC", location: "New England", website: "https://nefc.us", email: "updates@nefc.us", ages: "6-23", tuition: "$2000 - $3000", description: "NEFC is one of the top soccer clubs in the country focusing on player development and college placement. For more than 15 years NEFC has helped develop thousands of soccer players and enhance their playing experience.", icon: "https://nefc.us/wp-content/uploads/2021/07/NEFC_Crest_FINAL.png")
    static let sample2 = Academy(name: "Abbey Villa", location: "Massachusetts", website: "https://www.abbeyvillasoccer.com", phoneNumber: "781-435-6339", ages: "8-17", tuition: "$2000", description: "Abbey Villa S.C. (“AVSC”) emphasizes a player-centered development approach based on the Dutch principle of play, which revolutionized the game in the early 1970s, known as “Total Football” (totaalvoetbal). The legendary footballer, Johan Cruyff, who played and managed at F.C. Barcelona is credited with the enduring popularity and dominance of this style of play.", icon: "https://cdn1.sportngin.com/attachments/logo_graphic/10b6-144690373/AVSC_LOGO_CMYK.png")
    static let sample3 = Academy(name: "Boston Bolts", location: "Boston Area", website: "https://www.bostonbolts.com", email: "bolts@bostonbolts.com", ages: "5-19", tuition: "$3000 + $500 kit fee", description: "Founded in 1986, Boston Bolts is the oldest soccer club in Massachusetts. The Club boasts a top level, professional coaching staff, recognized and respected nation-wide. Bolts players come from throughout Massachusetts, New Hampshire, Connecticut and Rhode Island.", icon: "https://images.squarespace-cdn.com/content/v1/5fac3128d362aa01fcc0f6b2/1606333396820-7IWKHNFOY61GP7WB22BB/Boston_FC_Bolts4_292C.png?format=1500w")
    static let sampleData: [Academy] = [sample1, sample2, sample3]
}

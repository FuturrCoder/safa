//
//  UserData.swift
//  SAFA
//
//  Created by Mirai H DTN on 10/9/23.
//

import Foundation

struct UserData: Codable {
    let userId: String
    let createdAt: Date
    let email: String
    let photoUrl: String?
    let firstName: String
    let lastName: String
    let birthday: Date
    let isParent: Bool
    let childName: String
    let addressLine1: String
    let addressLine2: String
    let city: String
    let state: String
    let zipCode: String
}

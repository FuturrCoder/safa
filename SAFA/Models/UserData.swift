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
    
    var fullName: String {
        "\(firstName) \(lastName)"
    }
    
    var multiLineAddress: String {
        if addressLine2.isEmpty {
            return "\(addressLine1)\n\(city), \(state) \(zipCode)"
        } else {
            return "\(addressLine1)\n\(addressLine2)\n\(city), \(state) \(zipCode)"
        }
    }
    
    var birthdayShort: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        return dateFormatter.string(from: birthday)
    }
}

//
//  DatabaseManager.swift
//  SAFA
//
//  Created by Mirai H DTN on 10/9/23.
//

import Foundation
import FirebaseFirestore

@MainActor
final class DatabaseManager: ObservableObject {
    static let encoder: Firestore.Encoder = {
        let encoder = Firestore.Encoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return encoder
    }()
    
    static let decoder: Firestore.Decoder = {
        let decoder = Firestore.Decoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
}

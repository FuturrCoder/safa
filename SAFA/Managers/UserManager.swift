//
//  UserManager.swift
//  SAFA
//
//  Created by Mirai H DTN on 10/9/23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

final class UserManager: ObservableObject {
    private func userDocument(userId: String) -> DocumentReference {
        return Firestore.firestore().collection("users").document(userId)
    }
    
    func createNewUser(userData: UserData) throws {
        try userDocument(userId: userData.userId).setData(from: userData, merge: false, encoder: DatabaseManager.encoder)
    }
    
    func getUser(userId: String) async throws -> UserData {
        try await userDocument(userId: userId).getDocument(as: UserData.self, decoder: DatabaseManager.decoder)
    }
}

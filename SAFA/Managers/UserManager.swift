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
    
    func createNewUser(userData: UserData) async throws {
        try userDocument(userId: userData.userId).setData(from: userData, merge: false, encoder: DatabaseManager.encoder)
        try await FormManager().addDefaultForms(userId: userData.userId)
    }
    
    func getUser(userId: String) async throws -> UserData {
        try await userDocument(userId: userId).getDocument(as: UserData.self, decoder: DatabaseManager.decoder)
    }
    
    func toggleFollow(userId: String, academyId: String, nowFollowing: Bool) async throws {
        if nowFollowing {
            try await userDocument(userId: userId).updateData(["following": FieldValue.arrayUnion([academyId])])
        } else {
            try await userDocument(userId: userId).updateData(["following": FieldValue.arrayRemove([academyId])])
        }
    }
}

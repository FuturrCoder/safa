//
//  AcademyManager.swift
//  SAFA
//
//  Created by Mirai H DTN on 10/24/23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

@MainActor
final class AcademyManager: ObservableObject {
    private func academiesCollection() -> CollectionReference {
        return Firestore.firestore().collection("academies")
    }
    
    func getAcademies(userId: String, userManager: UserManager) async throws -> [Academy] {
        let querySnapshot = try await academiesCollection().getDocuments()
        var academies = try querySnapshot.documents.compactMap { try $0.data(as: Academy.self, decoder: DatabaseManager.decoder) }
        let following = try await userManager.getUser(userId: userId).following
        if !following.isEmpty {
            for (i, academy) in academies.enumerated() {
                if following.contains(academy.id.uuidString) {
                    academies[i].isFollowed = true
                }
            }
        }
        return academies
    }
    
//    func uploadAcademies() throws {
//        for academy in Academy.sampleData {
//            try Firestore.firestore().collection("academies").document(academy.id.uuidString)
//                .setData(from: academy, merge: false, encoder: DatabaseManager.encoder)
//        }
//    }
}

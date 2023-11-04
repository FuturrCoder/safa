//
//  FormManager.swift
//  SAFA
//
//  Created by Mirai H DTN on 10/24/23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

@MainActor
final class FormManager: ObservableObject {
    private func formsCollection(userId: String) -> CollectionReference {
        return Firestore.firestore().collection("users").document(userId).collection("forms")
    }
    
    func getForms(userId: String) async throws -> [ApplicationForm] {
        let querySnapshot = try await formsCollection(userId: userId).getDocuments()
        return try querySnapshot.documents.compactMap { try $0.data(as: ApplicationForm.self, decoder: DatabaseManager.decoder) }
    }
    
    func addDefaultForms(userId: String) async throws {
        let querySnapshot = try await Firestore.firestore().collection("forms").getDocuments()
        let forms = try querySnapshot.documents.compactMap {
            try $0.data(as: ApplicationForm.self, decoder: DatabaseManager.decoder)
        }
        for form in forms {
            try formsCollection(userId: userId).document(form.id.uuidString)
                .setData(from: form, merge: false, encoder: DatabaseManager.encoder)
        }
    }
    
    func updateForm(form: ApplicationForm, userId: String) async throws {
        try formsCollection(userId: userId).document(form.id.uuidString)
            .setData(from: form, merge: true, encoder: DatabaseManager.encoder)
    }
    
//    func createNewUser(userData: UserData) throws {
//        try userDocument(userId: userData.userId).setData(from: userData, merge: false, encoder: DatabaseManager.encoder)
//    }
    
//    func uploadForms() throws {
//        for form in ApplicationForm.sampleData {
//            try Firestore.firestore().collection("forms").document(form.id.uuidString)
//                .setData(from: form, merge: false, encoder: DatabaseManager.encoder)
//        }
//    }
    
//    func getUser(userId: String) async throws -> UserData {
//        try await userDocument(userId: userId).getDocument(as: UserData.self, decoder: DatabaseManager.decoder)
//    }
}

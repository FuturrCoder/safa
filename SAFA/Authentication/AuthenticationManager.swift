//
//  AuthenticationManager.swift
//  SAFA
//
//  Created by Mirai DTN on 7/14/23.
//

import Foundation
import FirebaseAuth

struct AuthDataResult {
    let uid: String
    let email: String?
    let photoUrl: String?
    
    init(user: User) {
        self.uid = user.uid
        self.email = user.email
        self.photoUrl = user.photoURL?.absoluteString
    }
}

final class AuthenticationManager: ObservableObject {
    static let testing = AuthenticationManager()
    
    init() {}
    
    func currentUser() -> AuthDataResult? {
        return Auth.auth().currentUser.map { AuthDataResult(user: $0) }
    }
    
    func currentUserRaw() -> User? {
        return Auth.auth().currentUser
    }
    
    @discardableResult
    func createUser(email: String, password: String) async throws -> AuthDataResult {
        let res = try await Auth.auth().createUser(withEmail: email, password: password)
        return AuthDataResult(user: res.user)
    }
    
    @discardableResult
    func signInUser(email: String, password: String) async throws -> AuthDataResult {
        let res = try await Auth.auth().signIn(withEmail: email, password: password)
        return AuthDataResult(user: res.user)
    }
    
    func resetPassword(email: String) async throws {
        try await Auth.auth().sendPasswordReset(withEmail: email)
    }
    
    func logOut() throws {
        try Auth.auth().signOut()
//        throw URLError(.badURL)
    }
    
    func delete(user: User) async throws {
        try await user.delete()
    }
}

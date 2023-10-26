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
    
    /// initializer for testing
    init(uid: String, email: String?, photoUrl: String?) {
        self.uid = uid
        self.email = email
        self.photoUrl = photoUrl
    }
}

// TODO: remove testing parts for production
final class AuthenticationManager: ObservableObject {
    /// for testing
    var mockUser: AuthDataResult? = nil
    var mockError: Error? = nil
    var mock = false
    static let sampleAuthDataResult = AuthDataResult(uid: "wuoq1fujs9NV0C12rWj0ZC6mY9T2", email: "example@example.com", photoUrl: "https://lh3.googleusercontent.com/a/ACg8ocIKp-q0RaGpmSUf5YG4MmVhVxk-5hBMvP2xCGGf0-y0NQ=s192-c-mo")
    
    @Published var reload = false
    
    init(mockUser: AuthDataResult, mockError: Error? = nil, mock: Bool = false) {
        self.mockUser = mockUser
        self.mockError = mockError
        self.mock = mock
    }
    
    static let mock = AuthenticationManager(mockUser: sampleAuthDataResult, mock: true)
    
    init() {}
    
    func currentUser() -> AuthDataResult? {
        if let user = mockUser {
            return user
        }
        
        return Auth.auth().currentUser.map { AuthDataResult(user: $0) }
    }
    
    func currentUserRaw() -> User? {
        return Auth.auth().currentUser
    }
    
    @discardableResult
    func createUser(email: String, password: String) async throws -> AuthDataResult {
        if let error = mockError {
            throw error
        } else if let user = mockUser {
            return user
        }
        
        let res = try await Auth.auth().createUser(withEmail: email, password: password)
        return AuthDataResult(user: res.user)
    }
    
    @discardableResult
    func signInUser(email: String, password: String) async throws -> AuthDataResult {
        if let error = mockError {
            throw error
        } else if let user = mockUser {
            return user
        }
        
        let res = try await Auth.auth().signIn(withEmail: email, password: password)
        reload = true
        return AuthDataResult(user: res.user)
    }
    
    func resetPassword(email: String) async throws {
        if let error = mockError {
            throw error
        }
        
        try await Auth.auth().sendPasswordReset(withEmail: email)
    }
    
    func logOut() throws {
        if let error = mockError {
            throw error
        }
        
        try Auth.auth().signOut()
    }
    
    func delete(user: User) async throws {
        if let error = mockError {
            throw error
        }
        
        try await user.delete()
    }
}

//
//  AuthenticationManager.swift
//  SAFA
//
//  Created by Mirai DTN on 7/14/23.
//

import Foundation
import FirebaseAuth

//struct AuthDataModel

final class AuthenticationManager: ObservableObject {
    init() {}
    
    func createUser(email: String, password: String) async throws {
        let _ = try await Auth.auth().createUser(withEmail: email, password: password)
    }
}

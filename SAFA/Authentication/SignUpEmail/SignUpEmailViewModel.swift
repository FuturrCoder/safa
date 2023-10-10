//
//  SignUpEmailViewModel.swift
//  SAFA
//
//  Created by Mirai H DTN on 10/9/23.
//

import Foundation

@MainActor
final class SignUpEmailViewModel: ObservableObject {
    @Published var firstName = ""
    @Published var lastName = ""
    @Published var email = ""
    @Published var password = ""
    @Published var confirmPassword = ""
    @Published var birthday = Date.now
    @Published var isParent = false
    @Published var childName = ""
    @Published var addressLine1 = ""
    @Published var addressLine2 = ""
    @Published var city = ""
    @Published var state = ""
    @Published var zipCode = ""
    @Published var error = ""
    
    var invalidName: Bool { firstName == "" || lastName == "" }
    var invalidEmail: Bool {
        let pred = NSPredicate(format: "SELF MATCHES %@", "^[^@ ]+@[^@ ]+\\.[A-Za-z]{2,}$")
        return !pred.evaluate(with: email)
    }
    var invalidPassword: Bool {
        let pred = NSPredicate(format: "SELF MATCHES %@", "(?=.*(\\W|\\d)).{6,}")
        return !pred.evaluate(with: password)
    }
    var unconfirmedPassword: Bool { password != confirmPassword }
    var invalidBirthday: Bool {
        Calendar.current.dateComponents([.year], from: birthday, to: Date.now).year! < 13 && !isParent
    }
    var invalidChildName: Bool { childName == "" && isParent}
    var invalidAddress: Bool { addressLine1 == "" || city == "" || state == "" || zipCode == "" }
    var invalid: Bool {
        invalidName || invalidPassword || unconfirmedPassword || invalidEmail || invalidBirthday || invalidChildName || invalidAddress
    }
    
    func signUp(authManager: AuthenticationManager, userManager: UserManager) {
        guard !invalid else { return }
        
        Task {
            do {
                let authDataResult = try await authManager.createUser(email: email, password: password)
                let userData = UserData(userId: authDataResult.uid, createdAt: Date(), email: email, photoUrl: authDataResult.photoUrl, firstName: firstName, lastName: lastName, birthday: birthday, isParent: isParent, childName: childName, addressLine1: addressLine1, addressLine2: addressLine2, city: city, state: state, zipCode: zipCode)
                try userManager.createNewUser(userData: userData)
            } catch {
                self.error = error.localizedDescription
            }
        }
    }
}

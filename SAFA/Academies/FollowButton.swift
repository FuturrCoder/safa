//
//  FollowButton.swift
//  SAFA
//
//  Created by Mirai H DTN on 10/25/23.
//

import SwiftUI

struct FollowButton: View {
    @Binding var academy: Academy
    @EnvironmentObject private var authenticationManager: AuthenticationManager
    @EnvironmentObject private var userManager: UserManager
    
    var body: some View {
        Button(action: {
            academy.isFollowed = !academy.isFollowed
            Task {
                let authDataResult = authenticationManager.currentUser()
                guard let authData = authDataResult else { return }
                do {
                    try await userManager.toggleFollow(userId: authData.uid, academyId: academy.id.uuidString, nowFollowing: academy.isFollowed)
                } catch {
                    print("Error updating academy follow: \(error.localizedDescription)")
                }
            }
        }) {
            Image(systemName: academy.isFollowed ? "star.fill" : "star")
                .foregroundColor(academy.isFollowed ? .accentColor : .gray)
        }
    }
}

#Preview("Follow Button") {
    FollowButton(academy: .constant(Academy.sample1))
        .environmentObject(AuthenticationManager.mock)
        .environmentObject(UserManager())
}

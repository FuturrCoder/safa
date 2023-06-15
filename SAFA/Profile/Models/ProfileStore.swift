//
//  ProfileStore.swift
//  SAFA
//
//  Created by Mirai DTN on 6/14/23.
//

import Foundation

@MainActor
class ProfileStore: ObservableObject {
    @Published var profile = Profile.sample
}

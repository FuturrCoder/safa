//
//  FormsStore.swift
//  SAFA
//
//  Created by Mirai DTN on 11/13/22.
//

import SwiftUI

@MainActor
final class FormsStore: ObservableObject {
    @Published var forms: [ApplicationForm] = ApplicationForm.sampleData
}

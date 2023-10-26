//
//  AcademiesStore.swift
//  SAFA
//
//  Created by Mirai DTN on 11/14/22.
//

import Foundation

@MainActor
final class AcademiesStore: ObservableObject {
    @Published var academies: [Academy] = []
    
    init(academies: [Academy]) {
        self.academies = academies
    }
}

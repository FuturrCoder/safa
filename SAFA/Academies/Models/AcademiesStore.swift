//
//  AcademiesStore.swift
//  SAFA
//
//  Created by Mirai DTN on 11/14/22.
//

import Foundation

class AcademiesStore: ObservableObject {
    @Published var academies: [Academy] = Academy.sampleData
}

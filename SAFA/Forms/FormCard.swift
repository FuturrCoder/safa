//
//  FormCard.swift
//  SAFA
//
//  Created by Mirai DTN on 11/13/22.
//

import SwiftUI

struct FormCard: View {
    let form: ApplicationForm
    
    var body: some View {
        HStack {
            Label(form.title, systemImage: form.icon)
                .font(.title2)
        }
        .padding()
    }
}

struct FormCard_Previews: PreviewProvider {
    static var previews: some View {
        FormCard(form: ApplicationForm.sampleData[0])
            .previewLayout(.sizeThatFits)
    }
}

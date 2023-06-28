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
//        HStack {
//            Label(form.title, systemImage: form.icon)
//                .font(.title2)
//        }
//        .padding()
        HStack(spacing: 15) {
            Image(systemName: form.icon)
                .font(.title2)
                .foregroundStyle(Color(.accent))
            VStack(alignment: .leading, spacing: 5) {
                Text(form.title)
                    .font(.title2)
                FormProgress(progress: form.progress, completed: form.completed)
            }
        }
        .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
    }
}

struct FormCard_Previews: PreviewProvider {
    static var previews: some View {
        FormCard(form: ApplicationForm.sampleData[0])
            .previewLayout(.sizeThatFits)
    }
}

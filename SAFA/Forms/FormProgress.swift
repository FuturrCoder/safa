//
//  FormProgress.swift
//  SAFA
//
//  Created by Mirai DTN on 6/22/23.
//

import SwiftUI

struct FormProgress: View {
    var progress: Float
    var completed: Bool
    
    var body: some View {
        HStack {
            ProgressView(value: progress)
                .animation(.easeInOut(duration: 0.7), value: progress)
            if completed {
                Image(systemName: "checkmark.circle")
                    .foregroundStyle(Color(.accent))
            } else {
                Text("\(Int(floor(progress * 100)))%")
            }
        }
    }
}

struct FormProgress_Previews: PreviewProvider {
    static var previews: some View {
        FormProgress(progress: 1/3, completed: true)
    }
}

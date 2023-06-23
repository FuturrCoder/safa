//
//  FormProgress.swift
//  SAFA
//
//  Created by Mirai DTN on 6/22/23.
//

import SwiftUI

struct FormProgress: View {
    var progress: Float
    
    var body: some View {
        HStack {
            ProgressView(value: progress)
                .animation(.easeInOut(duration: 0.7), value: progress)
            //                    .onChange(of: form.progress) { newValue in
            //                        print("\(form.answered),\(form.unanswered)")
            //                    }
            Text("\(Int(floor(progress * 100)))%")
        }
//        .padding(-5)
    }
}

struct FormProgress_Previews: PreviewProvider {
    static var previews: some View {
        FormProgress(progress: 1/3)
    }
}

//
//  VideoInput.swift
//  SAFA
//
//  Created by Mirai DTN on 6/13/23.
//

import SwiftUI

struct VideoInput: View {
    @Binding var isAnswered: Bool
    @Binding var response: VideoResponse
    
    var body: some View {
        Button {} label: {
            Spacer()
            Image(systemName: "plus")
            Spacer()
        }
//        .onAppear { isAnswered = true }
    }
}

struct VideoInput_Previews: PreviewProvider {
    static var previews: some View {
        VideoInput(isAnswered: .constant(true), response: .constant(VideoResponse()))
    }
}

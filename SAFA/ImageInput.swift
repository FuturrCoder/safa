//
//  ImageInput.swift
//  SAFA
//
//  Created by Mirai DTN on 6/13/23.
//

import SwiftUI

struct ImageInput: View {
    @Binding var isAnswered: Bool
    @Binding var response: ImageResponse
    
    var body: some View {
        Button {} label: {
            Spacer()
            Image(systemName: "plus")
            Spacer()
        }
    }
}

struct ImageInput_Previews: PreviewProvider {
    static var previews: some View {
        ImageInput(isAnswered: .constant(true), response: .constant(ImageResponse()))
    }
}

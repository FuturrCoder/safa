//
//  FileInput.swift
//  SAFA
//
//  Created by Mirai DTN on 6/13/23.
//

import SwiftUI

struct FileInput: View {
    @Binding var isAnswered: Bool
    @Binding var response: FileResponse
    
    var body: some View {
        Button {} label: {
            HStack {
                Spacer()
                Image(systemName: "plus")
                Spacer()
            }
        }
    }
}

struct FileInput_Previews: PreviewProvider {
    static var previews: some View {
        FileInput(isAnswered: .constant(true), response: .constant(FileResponse()))
    }
}

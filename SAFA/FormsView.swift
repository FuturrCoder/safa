//
//  FormsView.swift
//  SAFA
//
//  Created by Mirai DTN on 10/29/22.
//

import SwiftUI
import PhotosUI

struct FormsView: View {
    @ObservedObject var formData: FormData
    
    var body: some View {
        NavigationView {
            FormLink(formData: formData)
            FormLink(formData: formData)
        }
        // personal
        // upload videos
        // academy preference and level
        
        // once filled out, appears on profile
    }
}

struct FormsView_Previews: PreviewProvider {
    static var previews: some View {
        FormsView(formData: FormData())
    }
}


struct FormLink: View {
    @ObservedObject var formData: FormData
    
    var body: some View {
        NavigationLink(destination: FormView(formData: formData)) {
            Image(systemName: "person")
            Text("Personal Forms")
        }
        .navigationTitle("Forms")
    }
}

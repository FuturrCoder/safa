//
//  ProfileView.swift
//  SAFA
//
//  Created by Mirai DTN on 10/31/22.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        HStack {
            Circle()
                .foregroundColor(.white)
                .border(.black)
                .frame(maxWidth: 50)
                .overlay() {
                    Image(systemName: "person")
                        .padding()
                }
            VStack(alignment: .leading) {
                Text("Mirai DTN")
                    .font(.title2)
                Text("mnishioka@commschool.org")
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

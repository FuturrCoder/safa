//
//  AppBar.swift
//  SAFA
//
//  Created by Mirai DTN on 6/27/23.
//

import SwiftUI

extension View {
    func appBar(title: String) -> some View {
        self
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color("ThemeColor"), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: { print("clicked") }) {
                        Image(systemName: "gearshape")
                    }
                    .tint(.black)
                    .frame(width: 30)
                }
                ToolbarItem(placement: .principal) {
                    Image("Logo White")
                        .resizable()
                        .scaledToFit()
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {}) {
                        Image(systemName: "bell")
                    }
                    .tint(.black)
                    .frame(width: 30)
                }
            }
    }
    
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                        to: nil, from: nil, for: nil)
    }
}

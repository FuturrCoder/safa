//
//  AppBar.swift
//  SAFA
//
//  Created by Mirai DTN on 6/27/23.
//

import SwiftUI

extension View {
    func appBar(title: String) -> some View {
        // TODO: add toolbar background on iOS 15
        if #available(iOS 16.0, *) {
            return self
                .navigationTitle(title)
                .navigationBarTitleDisplayMode(.inline)
//                .toolbarBackground(Color("ThemeColor"), for: .navigationBar)
//                .toolbarBackground(.visible, for: .navigationBar)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        NavigationLink(destination: SettingsView()) {
                            Image(systemName: "gearshape")
                        }
//                        .tint(.black)
                        .frame(width: 30)
                    }
                    ToolbarItem(placement: .principal) {
                        Image("SAFA-mainlogo-blue")
                            .resizable()
                            .scaledToFit()
                            .scaleEffect(0.75)
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: {}) {
                            Image(systemName: "bell")
                        }
//                        .tint(.black)
                        .frame(width: 30)
                    }
                }
        } else {
            return self
                .navigationTitle(title)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        NavigationLink(destination: SettingsView()) {
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
    }
    
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                        to: nil, from: nil, for: nil)
    }
}

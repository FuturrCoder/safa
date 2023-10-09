//
//  AdditionalInfoView.swift
//  SAFA
//
//  Created by Mirai H DTN on 10/9/23.
//

import SwiftUI

struct AdditionalInfoView: View {
    @ObservedObject var viewModel: SignUpEmailViewModel
    
    var body: some View {
        Form {
            AgeInput(viewModel: viewModel)
            NameAndAddressInput(viewModel: viewModel)
        }
        .navigationTitle("Additional Info")
    }
}

#Preview("Additional Info") {
    NavigationView {
        AdditionalInfoView(viewModel: SignUpEmailViewModel())
    }
}

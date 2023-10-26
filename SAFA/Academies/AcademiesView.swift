//
//  AcademyView.swift
//  SAFA
//
//  Created by Mirai DTN on 10/30/22.
//

import SwiftUI

@MainActor
final class AcademiesViewModel: ObservableObject {
    @Published var academiesStore: AcademiesStore = AcademiesStore(academies: [])
    private var academyManager = AcademyManager()
    var selectedAcademy: String?
    
    func loadAcademies(authMan: AuthenticationManager, userMan: UserManager) async {
        let authDataResult = authMan.currentUser()
        guard let authData = authDataResult else { return }
        academiesStore = (try? await AcademiesStore(academies: academyManager
            .getAcademies(userId: authData.uid, userManager: userMan))) ?? AcademiesStore(academies: [])
//        print(academiesStore.academies)
    }
    
//    func uploadAcademies() throws {
//        try academyManager.uploadAcademies()
//    }
}

struct AcademiesView: View {
    // TODO: Add search
    
//    @Binding var academies: [Academy]
    @StateObject private var viewModel = AcademiesViewModel()
    @EnvironmentObject private var authenticationManager: AuthenticationManager
    @EnvironmentObject private var userManager: UserManager
    
    var body: some View {
        NavigationView {
            if !viewModel.academiesStore.academies.isEmpty {
                ScrollView {
//                    Group {
                        HStack {
                            Text("Academies")
                                .font(.largeTitle)
                                .bold()
                                .padding(.leading, 20)
                            Spacer()
                        }
    //                    Section {
                            ForEach($viewModel.academiesStore.academies) { $academy in
                                HStack {
    //                                Button(action: {
    //                                    print("old: \(viewModel.selectedAcademy ?? "none")")
    //                                    viewModel.selectedAcademy = academy.id.uuidString
    //                                    print("new: \(viewModel.selectedAcademy ?? "none")")
    //                                }) {
    //                                    AcademyCard(academy: $academy)
    //                                }
//                                    NavigationLink(destination: AcademyDetail(academy: $academy),
//                                                   tag: academy.id.uuidString,
//                                                   selection: $viewModel.selectedAcademy,
//                                                   label: {EmptyView()})
//                                    AcademyCard(academy: $academy)
//                                        .overlay(
//                                            NavigationLink(destination: AcademyDetail(academy: $academy)) {
////                                                AcademyCard(academy: $academy)
//                                                // rectangle that fills available area
//                                                Rectangle()
//                                                    .fill(Color.clear)
//                                                    .contentShape(Rectangle())
//                                            }
////                                            .opacity(0)
//                                        )
                                    NavigationLink(destination: AcademyDetail(academy: $academy)) {
                                        AcademyCard(academy: $academy)
                                    }
                                    Spacer()
                                    FollowButton(academy: $academy)
                                }
                                .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 10))
                                .background(Color(UIColor.secondarySystemGroupedBackground)
                                    .clipShape(RoundedRectangle(cornerRadius:10)))
                                
//                                .listRowSeparator(.hidden)
                            }
    //                    } header: {
    //                        Text("Academies")
    //                            .font(.largeTitle)
    //                            .bold()
    //                            .padding(.top)
    //                    }
    //                    .headerProminence(.increased)
//                    }
                }
                .padding(20)
                .background(Color(UIColor.systemGroupedBackground))
                .appBar(title: "Academies")
            } else {
                ProgressView()
                    .appBar(title: "Academies")
            }
        }
        .task {
            await viewModel.loadAcademies(authMan: authenticationManager, userMan: userManager)
        }
    }
}

#Preview("Academies View") {
    AcademiesView()
        .environmentObject(AuthenticationManager.mock)
        .environmentObject(UserManager())
}

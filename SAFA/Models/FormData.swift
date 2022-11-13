//
//  FormData.swift
//  SAFA
//
//  Created by Mirai DTN on 10/29/22.
//

import Foundation
import SwiftUI
import PhotosUI

class FormData: ObservableObject {
    @Published var experience: String = ""
    @Published var financial: String = ""
    
    enum ImageState {
        case empty, loading(Progress), success(Image), failure(Error)
    }
    
    @Published private(set) var dribblingState: ImageState = .empty
    @Published var dribblingSelection: PhotosPickerItem? {
        didSet {
            if let dribblingSelection {
                let progress = loadImage(from: dribblingSelection)
                dribblingState = .loading(progress)
            } else {
                dribblingState = .empty
            }
        }
    }
    
    private func loadImage(from imageSelection: PhotosPickerItem) -> Progress {
        return imageSelection.loadTransferable(type: Image.self) { result in
            DispatchQueue.main.async {
                
            }
        }
    }
}


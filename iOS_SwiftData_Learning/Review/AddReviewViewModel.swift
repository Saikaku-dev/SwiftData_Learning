//
//  AddReviewViewModel.swift
//  iOS_SwiftData_Learning
//
//  Created by cmStudent on 2025/05/26.
//

import Foundation
import SwiftData
import UIKit

class AddReviewViewModel: ObservableObject {
    @Published var title: String = ""
    @Published var content: String = ""
    @Published var photos: [UIImage] = []
    @Published var selectedPhotoIndices: Set<Int> = []
    @Published var rating: Int = 0
    @Published var showImagePicker: Bool = false
    @Published var showCameraPicker: Bool = false
    
    func addPhoto(_ img: UIImage) {
        if photos.count < 3 {
            photos.append(img)
        }
    }

    func deleteSelectedPhotos() {
        for index in selectedPhotoIndices.sorted(by: >) {
            photos.remove(at: index)
        }
        selectedPhotoIndices.removeAll()
    }
    
    func saveReview() {
        
    }
}

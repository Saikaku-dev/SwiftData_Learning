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
    
    var mapViewModel: MapViewModel
    var placeId: UUID

    init(mapViewModel: MapViewModel, placeId: UUID) {
        self.mapViewModel = mapViewModel
        self.placeId = placeId
    }

    var currentPlace: PlaceModel? {
        mapViewModel.places.first(where: { $0.id == placeId })
    }

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
        var fileName: String? = nil
        if let image = photos.first {
            fileName = saveImageToDisk(image: image)
        }
        
        let review = ReviewModel(
            title: title,
            content: content,
            photoFileName: fileName,
            rating: rating,
            createdAt: Date()
        )
        if let index = mapViewModel.places.firstIndex(where: { $0.id == placeId }) {
            mapViewModel.places[index].reviews.append(review)
        }
    }

    func saveImageToDisk(image: UIImage) -> String? {
        let fileName = UUID().uuidString + ".jpg"
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(fileName)
        if let data = image.jpegData(compressionQuality: 0.8) {
            try? data.write(to: url)
            return fileName
        }
        return nil
    }
}

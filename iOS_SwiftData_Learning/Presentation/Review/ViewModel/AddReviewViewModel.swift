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
    @Published var isLoading: Bool = false
    
    private let reviewUseCase: ReviewUseCase
    private let reviewDataSource: LocalReviewDataSource
    private let mapViewModel: MapViewModel
    private let placeId: UUID
    
    init(mapViewModel: MapViewModel, 
         placeId: UUID,
         reviewUseCase: ReviewUseCase = DIContainer.shared.reviewUseCase,
         reviewDataSource: LocalReviewDataSource = LocalReviewDataSource()) {
        self.mapViewModel = mapViewModel
        self.placeId = placeId
        self.reviewUseCase = reviewUseCase
        self.reviewDataSource = reviewDataSource
    }
    
    var currentPlace: PlaceEntity? {
        mapViewModel.places.first(where: { $0.id == placeId })
    }
    
    var isFormValid: Bool {
        !title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        !content.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        rating > 0
    }
    
    func addPhoto(_ image: UIImage) {
        if photos.count < 3 {
            photos.append(image)
        }
    }
    
    func deleteSelectedPhotos() {
        for index in selectedPhotoIndices.sorted(by: >) {
            photos.remove(at: index)
        }
        selectedPhotoIndices.removeAll()
    }
    
    func saveReview() {
        guard isFormValid else { return }
        
        isLoading = true
        
        var fileName: String?
        if let image = photos.first {
            fileName = reviewDataSource.saveImage(image)
        }
        
        let review = ReviewEntity(
            title: title.trimmingCharacters(in: .whitespacesAndNewlines),
            content: content.trimmingCharacters(in: .whitespacesAndNewlines),
            photoFileName: fileName,
            rating: rating,
            createdAt: Date()
        )
        
        // 使用UseCase保存review
        reviewUseCase.addReview(review, for: placeId)
        
        // 更新MapViewModel中的数据
        if let index = mapViewModel.places.firstIndex(where: { $0.id == placeId }) {
            mapViewModel.places[index].reviews.append(review)
        }
        
        isLoading = false
        resetForm()
    }
    
    private func resetForm() {
        title = ""
        content = ""
        photos = []
        selectedPhotoIndices = []
        rating = 0
    }
}

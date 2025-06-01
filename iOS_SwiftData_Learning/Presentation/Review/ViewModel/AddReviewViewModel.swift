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

    var currentPlace: PlaceEntity? {
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
        
        let review = ReviewEntity(
            title: title,
            content: content,
            photoFileName: fileName,
            rating: rating,
            createdAt: Date()
        )
        
        // 保存到内存
        if let index = mapViewModel.places.firstIndex(where: { $0.id == placeId }) {
            mapViewModel.places[index].reviews.append(review)
            
            // 保存该地点的所有reviews到文件
            let allReviews = mapViewModel.places[index].reviews
            saveReviewsForPlace(placeId: placeId, reviews: allReviews)
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
    
    // 保存单个review到本地文件
    func saveReviewToDisk(review: ReviewEntity) -> String? {
        let fileName = "review_\(review.id.uuidString).json"
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(fileName)
        
        do {
            let data = try JSONEncoder().encode(review)
            try data.write(to: url)
            return fileName
        } catch {
            print("保存review失败: \(error)")
            return nil
        }
    }
    
    // 从本地文件读取review
    func loadReviewFromDisk(fileName: String) -> ReviewEntity? {
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(fileName)
        
        do {
            let data = try Data(contentsOf: url)
            let review = try JSONDecoder().decode(ReviewEntity.self, from: data)
            return review
        } catch {
            print("读取review失败: \(error)")
            return nil
        }
    }
    
    // 保存所有reviews到一个文件
    func saveAllReviewsToDisk(reviews: [ReviewEntity]) -> Bool {
        let fileName = "all_reviews.json"
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(fileName)
        
        do {
            let data = try JSONEncoder().encode(reviews)
            try data.write(to: url)
            return true
        } catch {
            print("保存所有reviews失败: \(error)")
            return false
        }
    }
    
    // 从本地文件读取所有reviews
    func loadAllReviewsFromDisk() -> [ReviewEntity] {
        let fileName = "all_reviews.json"
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(fileName)
        
        do {
            let data = try Data(contentsOf: url)
            let reviews = try JSONDecoder().decode([ReviewEntity].self, from: data)
            return reviews
        } catch {
            print("读取所有reviews失败: \(error)")
            return []
        }
    }
    
    // 为特定地点保存reviews
    func saveReviewsForPlace(placeId: UUID, reviews: [ReviewEntity]) {
        let fileName = "reviews_\(placeId.uuidString).json"
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(fileName)
        
        do {
            let data = try JSONEncoder().encode(reviews)
            try data.write(to: url)
            print("地点 \(placeId) 的reviews保存成功")
        } catch {
            print("保存地点 \(placeId) 的reviews失败: \(error)")
        }
    }
}

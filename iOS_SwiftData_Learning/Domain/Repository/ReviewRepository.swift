//
//  ReviewRepository.swift
//  iOS_SwiftData_Learning
//
//  Created by cmStudent on 2025/06/01.
//

import Foundation

protocol ReviewRepository {
    func getReviews(for placeId: UUID) -> [ReviewEntity]
    func saveReview(_ review: ReviewEntity, for placeId: UUID)
    func saveReviews(_ reviews: [ReviewEntity], for placeId: UUID)
    func deleteReview(id: UUID, for placeId: UUID)
}

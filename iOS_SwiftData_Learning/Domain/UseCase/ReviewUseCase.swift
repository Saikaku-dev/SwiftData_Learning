//
//  ReviewUseCase.swift
//  iOS_SwiftData_Learning
//
//  Created by cmStudent on 2025/06/01.
//

import Foundation

class ReviewUseCase {
    private let reviewRepository: ReviewRepository
    
    init(reviewRepository: ReviewRepository) {
        self.reviewRepository = reviewRepository
    }
    
    func getReviews(for placeId: UUID) -> [ReviewEntity] {
        return reviewRepository.getReviews(for: placeId)
    }
    
    func addReview(_ review: ReviewEntity, for placeId: UUID) {
        reviewRepository.saveReview(review, for: placeId)
    }
    
    func saveReviews(_ reviews: [ReviewEntity], for placeId: UUID) {
        reviewRepository.saveReviews(reviews, for: placeId)
    }
    
    func deleteReview(id: UUID, for placeId: UUID) {
        reviewRepository.deleteReview(id: id, for: placeId)
    }
}

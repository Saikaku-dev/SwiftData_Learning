//
//  ReviewRepositoryImpl.swift
//  iOS_SwiftData_Learning
//
//  Created by cmStudent on 2025/06/01.
//

import Foundation

class ReviewRepositoryImpl: ReviewRepository {
    private let localDataSource: LocalReviewDataSource
    
    init(localDataSource: LocalReviewDataSource = LocalReviewDataSource()) {
        self.localDataSource = localDataSource
    }
    
    func getReviews(for placeId: UUID) -> [ReviewEntity] {
        return localDataSource.loadReviews(for: placeId)
    }
    
    func saveReview(_ review: ReviewEntity, for placeId: UUID) {
        var reviews = localDataSource.loadReviews(for: placeId)
        reviews.append(review)
        localDataSource.saveReviews(reviews, for: placeId)
    }
    
    func saveReviews(_ reviews: [ReviewEntity], for placeId: UUID) {
        localDataSource.saveReviews(reviews, for: placeId)
    }
    
    func deleteReview(id: UUID, for placeId: UUID) {
        var reviews = localDataSource.loadReviews(for: placeId)
        reviews.removeAll { $0.id == id }
        localDataSource.saveReviews(reviews, for: placeId)
    }
}

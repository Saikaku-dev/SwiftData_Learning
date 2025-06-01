//
//  DIContainer.swift
//  iOS_SwiftData_Learning
//
//  Created by cmStudent on 2025/06/01.
//

import Foundation

class DIContainer {
    static let shared = DIContainer()
    
    private init() {}
    
    // MARK: - Data Sources
    lazy var localPlaceDataSource: LocalPlaceDataSource = LocalPlaceDataSource()
    lazy var localReviewDataSource: LocalReviewDataSource = LocalReviewDataSource()
    
    // MARK: - Repositories
    lazy var placeRepository: PlaceRepository = PlaceRepositoryImpl(
        localDataSource: localPlaceDataSource
    )
    
    lazy var reviewRepository: ReviewRepository = ReviewRepositoryImpl(
        localDataSource: localReviewDataSource
    )
    
    lazy var locationRepository: LocationRepository = LocationRepositoryImpl()
    
    // MARK: - Use Cases
    lazy var placeUseCase: PlaceUseCase = PlaceUseCase(
        placeRepository: placeRepository,
        reviewRepository: reviewRepository
    )
    
    lazy var reviewUseCase: ReviewUseCase = ReviewUseCase(
        reviewRepository: reviewRepository
    )
    
    lazy var locationUseCase: LocationUseCase = LocationUseCase(
        locationRepository: locationRepository
    )
}

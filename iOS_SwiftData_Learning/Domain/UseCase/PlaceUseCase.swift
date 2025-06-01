//
//  PlaceUseCase.swift
//  iOS_SwiftData_Learning
//
//  Created by cmStudent on 2025/06/01.
//

import Foundation

class PlaceUseCase {
    private let placeRepository: PlaceRepository
    private let reviewRepository: ReviewRepository
    
    init(placeRepository: PlaceRepository, reviewRepository: ReviewRepository) {
        self.placeRepository = placeRepository
        self.reviewRepository = reviewRepository
    }
    
    func getAllPlaces() -> [PlaceEntity] {
        var places = placeRepository.getAllPlaces()
        
        // 为每个地点加载reviews
        for i in 0..<places.count {
            let reviews = reviewRepository.getReviews(for: places[i].id)
            places[i].reviews = reviews
        }
        
        return places
    }
    
    func getPlace(by id: UUID) -> PlaceEntity? {
        guard var place = placeRepository.getPlace(by: id) else { return nil }
        place.reviews = reviewRepository.getReviews(for: id)
        return place
    }
    
    func savePlaces(_ places: [PlaceEntity]) {
        placeRepository.savePlaces(places)
    }
}

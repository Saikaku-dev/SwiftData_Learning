//
//  PlacesManager.swift
//  iOS_SwiftData_Learning
//
//  Created by cmStudent on 2025/05/26.
//


import Foundation

class PlaceRepositoryImpl: PlaceRepository {
    private let localDataSource: LocalPlaceDataSource
    
    init(localDataSource: LocalPlaceDataSource = LocalPlaceDataSource()) {
        self.localDataSource = localDataSource
    }
    
    func getAllPlaces() -> [PlaceEntity] {
        return localDataSource.loadPlaces()
    }
    
    func getPlace(by id: UUID) -> PlaceEntity? {
        return localDataSource.loadPlaces().first { $0.id == id }
    }
    
    func savePlaces(_ places: [PlaceEntity]) {
        localDataSource.savePlaces(places)
    }
}
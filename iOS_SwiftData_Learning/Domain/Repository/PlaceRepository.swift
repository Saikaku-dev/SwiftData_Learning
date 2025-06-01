//
//  PlaceRepository.swift
//  iOS_SwiftData_Learning
//
//  Created by cmStudent on 2025/06/01.
//

import Foundation

protocol PlaceRepository {
    func getAllPlaces() -> [PlaceEntity]
    func getPlace(by id: UUID) -> PlaceEntity?
    func savePlaces(_ places: [PlaceEntity])
}

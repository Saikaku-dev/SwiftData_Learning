//
//  PlaceModel.swift
//  iOS_SwiftData_Learning
//
//  Created by cmStudent on 2025/05/26.
//

import Foundation

struct PlaceEntity: Identifiable, Codable {
    let id: UUID
    let name: String
    let category: String
    let latitude: Double
    let longitude: Double
    var reviews: [ReviewEntity]
    
    init(id: UUID = UUID(),
         name: String,
         category: String,
         latitude: Double,
         longitude: Double,
         reviews: [ReviewEntity] = []) {
        self.id = id
        self.name = name
        self.category = category
        self.latitude = latitude
        self.longitude = longitude
        self.reviews = reviews
    }
}

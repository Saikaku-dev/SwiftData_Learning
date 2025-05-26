//
//  PlaceModel.swift
//  iOS_SwiftData_Learning
//
//  Created by cmStudent on 2025/05/26.
//

import Foundation

struct PlaceModel: Decodable, Identifiable {
    let id = UUID()
    let name: String
    let category: String
    let latitude: Double
    let longitude: Double
    
    init(name: String, category: String, latitude: Double, longitude: Double) {
        self.name = name
        self.category = category
        self.latitude = latitude
        self.longitude = longitude
    }
}

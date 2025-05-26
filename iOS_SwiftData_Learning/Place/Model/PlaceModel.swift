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
    var reviews: [ReviewModel] = []
    
    // 自定义解码
    private enum CodingKeys: String, CodingKey {
        case name, category, latitude, longitude
    }

    init(name: String, category: String, latitude: Double, longitude: Double, reviews: [ReviewModel] = []) {
        self.name = name
        self.category = category
        self.latitude = latitude
        self.longitude = longitude
        self.reviews = reviews
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.category = try container.decode(String.self, forKey: .category)
        self.latitude = try container.decode(Double.self, forKey: .latitude)
        self.longitude = try container.decode(Double.self, forKey: .longitude)
        self.reviews = [] // JSON里没有，初始化为空
    }
}

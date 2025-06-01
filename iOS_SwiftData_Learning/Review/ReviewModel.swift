//
//  ReviewModel.swift
//  iOS_SwiftData_Learning
//
//  Created by cmStudent on 2025/05/26.
//

import Foundation

struct ReviewModel: Codable {
    let id = UUID()
    let title: String
    let content: String
    let photoFileName: String?
    let rating: Int
    var createdAt: Date
    
    init(title: String, content: String, photoFileName: String?, rating: Int, createdAt: Date) {
        self.title = title
        self.content = content
        self.photoFileName = photoFileName
        self.rating = rating
        self.createdAt = createdAt
    }
}

//
//  ReviewModel.swift
//  iOS_SwiftData_Learning
//
//  Created by cmStudent on 2025/05/26.
//

import Foundation

struct ReviewEntity: Identifiable, Codable {
    let id: UUID
    let title: String
    let content: String
    let photoFileName: String?
    let rating: Int
    let createdAt: Date
    
    init(id: UUID = UUID(), title: String, content: String, photoFileName: String?, rating: Int, createdAt: Date) {
        self.id = id
        self.title = title
        self.content = content
        self.photoFileName = photoFileName
        self.rating = rating
        self.createdAt = createdAt
    }
}

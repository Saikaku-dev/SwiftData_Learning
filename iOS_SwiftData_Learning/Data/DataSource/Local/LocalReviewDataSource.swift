//
//  LocalReviewDataSource.swift
//  iOS_SwiftData_Learning
//
//  Created by cmStudent on 2025/06/01.
//

import Foundation
import UIKit

class LocalReviewDataSource {
    func loadReviews(for placeId: UUID) -> [ReviewEntity] {
        let fileName = "reviews_\(placeId.uuidString).json"
        let url = getDocumentsURL().appendingPathComponent(fileName)
        
        guard FileManager.default.fileExists(atPath: url.path) else {
            return []
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            return try decoder.decode([ReviewEntity].self, from: data)
        } catch {
            print("加载地点 \(placeId) 的reviews失败: \(error)")
            return []
        }
    }
    
    func saveReviews(_ reviews: [ReviewEntity], for placeId: UUID) {
        let fileName = "reviews_\(placeId.uuidString).json"
        let url = getDocumentsURL().appendingPathComponent(fileName)
        
        do {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601
            encoder.outputFormatting = .prettyPrinted
            let data = try encoder.encode(reviews)
            try data.write(to: url)
        } catch {
            print("保存地点 \(placeId) 的reviews失败: \(error)")
        }
    }
    
    func saveImage(_ image: UIImage) -> String? {
        let fileName = UUID().uuidString + ".jpg"
        let url = getDocumentsURL().appendingPathComponent(fileName)
        
        guard let data = image.jpegData(compressionQuality: 0.8) else {
            return nil
        }
        
        do {
            try data.write(to: url)
            return fileName
        } catch {
            print("保存图片失败: \(error)")
            return nil
        }
    }
    
    func loadImage(fileName: String) -> UIImage? {
        let url = getDocumentsURL().appendingPathComponent(fileName)
        return UIImage(contentsOfFile: url.path)
    }
    
    private func getDocumentsURL() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}

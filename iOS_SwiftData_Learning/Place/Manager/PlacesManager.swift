//
//  PlacesManager.swift
//  iOS_SwiftData_Learning
//
//  Created by cmStudent on 2025/05/26.
//


import Foundation

class PlacesManager {
    static let shared = PlacesManager()
    
    func loadPlaceData() -> [PlaceModel] {
        guard let path = Bundle.main.url(forResource: "Places", withExtension: "json") else {
            print("PATHが見つかりません。")
            return []
        }
        
        do {
            let data = try Data(contentsOf: path)
            let decoder = JSONDecoder()
            let decodeResult = try decoder.decode([PlaceModel].self, from: data)
            return decodeResult
        } catch {
            print("データが見つかりません。\(error.localizedDescription)")
            return []
        }
    }
}
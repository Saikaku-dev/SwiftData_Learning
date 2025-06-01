//
//  PlacesManager.swift
//  iOS_SwiftData_Learning
//
//  Created by cmStudent on 2025/05/26.
//


import Foundation

class PlaceRepositoryImpl {
    static let shared = PlaceRepositoryImpl()
    
    func loadPlaceData() -> [PlaceEntity] {
        guard let path = Bundle.main.url(forResource: "Places", withExtension: "json") else {
            print("PATHが見つかりません。")
            return []
        }
        
        do {
            let data = try Data(contentsOf: path)
            let decoder = JSONDecoder()
            let decodeResult = try decoder.decode([PlaceEntity].self, from: data)
            return decodeResult
        } catch {
            print("データが見つかりません。\(error.localizedDescription)")
            return []
        }
    }
}
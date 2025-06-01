//
//  LocalPlaceDataSource.swift
//  iOS_SwiftData_Learning
//
//  Created by cmStudent on 2025/06/01.
//

import Foundation

class LocalPlaceDataSource {
    private let fileName = "places_data.json"
    
    func loadPlaces() -> [PlaceEntity] {
        // 首先尝试从Documents目录加载
        if let savedPlaces = loadSavedPlaces(), !savedPlaces.isEmpty {
            return savedPlaces
        }
        
        // 如果没有保存的数据，从Bundle加载初始数据
        return loadInitialPlaces()
    }
    
    private func loadSavedPlaces() -> [PlaceEntity]? {
        let url = getDocumentsURL().appendingPathComponent(fileName)
        
        guard FileManager.default.fileExists(atPath: url.path) else {
            return nil
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            return try decoder.decode([PlaceEntity].self, from: data)
        } catch {
            print("加载保存的地点数据失败: \(error)")
            return nil
        }
    }
    
    private func loadInitialPlaces() -> [PlaceEntity] {
        guard let path = Bundle.main.url(forResource: "Places", withExtension: "json") else {
            print("Places.json文件未找到")
            return []
        }
        
        do {
            let data = try Data(contentsOf: path)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            return try decoder.decode([PlaceEntity].self, from: data)
        } catch {
            print("加载初始地点数据失败: \(error)")
            return []
        }
    }
    
    func savePlaces(_ places: [PlaceEntity]) {
        let url = getDocumentsURL().appendingPathComponent(fileName)
        
        do {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601
            encoder.outputFormatting = .prettyPrinted
            let data = try encoder.encode(places)
            try data.write(to: url)
        } catch {
            print("保存地点数据失败: \(error)")
        }
    }
    
    private func getDocumentsURL() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}

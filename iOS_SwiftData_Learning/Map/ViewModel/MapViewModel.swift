//
//  MapViewModel.swift
//  iOS_SwiftData_Learning
//
//  Created by cmStudent on 2025/05/26.
//

import Foundation
import MapKit
import SwiftUI

class MapViewModel: ObservableObject {
    @Published var places:[PlaceModel] = []
    @Published var locationManager:LocationManager = LocationManager()
    @Published var cameraPostion: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 35.698838, longitude: 139.696902),
            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        )
    )
    @Published var showPlaceDetail: Bool = false
    @Published var shouldAddReview: Bool = false
    @Published var selectedPlaceId: UUID?
    
    init() {
        loadPlaces()
        loadSavedReviews() // 在初始化时加载已保存的reviews
    }
    
    func loadPlaces() {
        self.places = PlacesManager.shared.loadPlaceData()
    }
    
    // 加载所有地点的已保存reviews
    func loadSavedReviews() {
        for i in 0..<places.count {
            let placeId = places[i].id
            let savedReviews = loadReviewsForPlace(placeId: placeId)
            places[i].reviews = savedReviews
        }
    }
    
    // 为特定地点加载reviews
    func loadReviewsForPlace(placeId: UUID) -> [ReviewModel] {
        let fileName = "reviews_\(placeId.uuidString).json"
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(fileName)
        
        do {
            let data = try Data(contentsOf: url)
            let reviews = try JSONDecoder().decode([ReviewModel].self, from: data)
            return reviews
        } catch {
            print("读取地点 \(placeId) 的reviews失败: \(error)")
            return []
        }
    }
    
    // 从磁盘加载图片
    func loadImageFromDisk(fileName: String) -> UIImage? {
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(fileName)
        return UIImage(contentsOfFile: url.path)
    }
    
    func dateString(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        return formatter.string(from: date)
    }
}

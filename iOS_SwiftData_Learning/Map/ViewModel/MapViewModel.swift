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
    @Published var selectedPlace:PlaceModel?
    @Published var shouldNavigateToAddReview: Bool = false
    
    init() {
        loadPlaces()
    }
    
    func loadPlaces() {
        self.places = PlacesManager.shared.loadPlaceData()
    }
}

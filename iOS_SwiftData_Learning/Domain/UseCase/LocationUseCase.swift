//
//  LocationUseCase.swift
//  iOS_SwiftData_Learning
//
//  Created by cmStudent on 2025/06/01.
//

import Foundation
import CoreLocation

class LocationUseCase {
    private let locationRepository: LocationRepository
    
    init(locationRepository: LocationRepository) {
        self.locationRepository = locationRepository
    }
    
    func getCurrentLocation() async throws -> CLLocation {
        return try await locationRepository.getCurrentLocation()
    }
    
    func requestLocationPermission() {
        locationRepository.requestLocationPermission()
    }
    
    func isLocationPermissionGranted() -> Bool {
        return locationRepository.isLocationPermissionGranted()
    }
}

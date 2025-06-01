//
//  LocationRepository.swift
//  iOS_SwiftData_Learning
//
//  Created by cmStudent on 2025/06/01.
//

import Foundation
import CoreLocation

protocol LocationRepository {
    func getCurrentLocation() async throws -> CLLocation
    func requestLocationPermission()
    func isLocationPermissionGranted() -> Bool
}

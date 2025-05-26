import Foundation
import MapKit
import SwiftUI

class LocationManager:NSObject,ObservableObject,CLLocationManagerDelegate {
    
    private let locationManager = CLLocationManager()
    @Published var currentLocation: CLLocationCoordinate2D?
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager,didUpdateLocations locations: [CLLocation]) {
        print("位置情報取得中")
        guard let location = locations.last else { return }
        DispatchQueue.main.async {
            self.currentLocation = location.coordinate
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print("権限状態：\(manager.authorizationStatus.rawValue)")
        
        switch manager.authorizationStatus {
            case .authorizedWhenInUse, .authorizedAlways:
                print("権限取得")
                locationManager.startUpdatingLocation()
            default:
                print("権限なし")
            }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("位置取得失敗: \(error.localizedDescription)")
    }

}

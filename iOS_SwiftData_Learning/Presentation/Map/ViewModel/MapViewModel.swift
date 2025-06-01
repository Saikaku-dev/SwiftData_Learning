import Foundation
import MapKit
import SwiftUI

class MapViewModel: ObservableObject {
    @Published var places: [PlaceEntity] = []
    @Published var cameraPosition: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 35.698838, longitude: 139.696902),
            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        )
    )
    @Published var showPlaceDetail: Bool = false
    @Published var shouldAddReview: Bool = false
    @Published var selectedPlaceId: UUID?
    
    private let placeUseCase: PlaceUseCase
    private let locationUseCase: LocationUseCase
    private let reviewDataSource: LocalReviewDataSource
    
    init(placeUseCase: PlaceUseCase = DIContainer.shared.placeUseCase,
         locationUseCase: LocationUseCase = DIContainer.shared.locationUseCase,
         reviewDataSource: LocalReviewDataSource = LocalReviewDataSource()) {
        self.placeUseCase = placeUseCase
        self.locationUseCase = locationUseCase
        self.reviewDataSource = reviewDataSource
        loadPlaces()
    }
    
    func loadPlaces() {
        self.places = placeUseCase.getAllPlaces()
        print("取得したPlaceの個数: \(places.count)")
        for (index, place) in places.enumerated() {
            print("\(index + 1). \(place.name) - \(place.category)")
        }
    }
    
    func refreshPlaces() {
        loadPlaces()
    }
    
    func loadImageFromDisk(fileName: String) -> UIImage? {
        return reviewDataSource.loadImage(fileName: fileName)
    }
    
    func dateString(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        return formatter.string(from: date)
    }
    
    var selectedPlace: PlaceEntity? {
        guard let selectedPlaceId = selectedPlaceId else { return nil }
        return places.first { $0.id == selectedPlaceId }
    }
}

//
//  ContentView.swift
//  iOS_SwiftData_Learning
//
//  Created by cmStudent on 2025/05/26.
//

import SwiftUI
import MapKit

struct MapView: View {
    @EnvironmentObject var vm: MapViewModel
    @EnvironmentObject var route: NavigationRouter
    
    var body: some View {
            Map(position: $vm.cameraPosition) {
                UserAnnotation()
                ForEach(vm.places) { place in
                    Annotation(
                        place.name,
                        coordinate:CLLocationCoordinate2D(
                            latitude: place.latitude,
                            longitude: place.longitude)
                    ) {
                        VStack {
                            Image(systemName: "mappin.circle.fill")
                                .font(.title)
                                .foregroundColor(.red)
                                .background(Color.white)
                                .clipShape(Circle())
                        }
                        .onTapGesture {
                            vm.selectedPlaceId = place.id
                            vm.showPlaceDetail = true
                        }
                    }
                }
            }
            .mapStyle(.standard(pointsOfInterest: .excludingAll))
            .mapControls {
                MapUserLocationButton()
                MapPitchToggle()
            }
            .sheet(isPresented: $vm.showPlaceDetail, onDismiss: {
                if vm.shouldAddReview {
                    route.navigate(to: .addReview)
                    vm.shouldAddReview = false
                }
            }) {
                PlaceDetailSheet(vm: vm)
                    .presentationDetents([.fraction(0.4)])
            }
    }
}

#Preview {
    NavigationStack {
        MapView()
    }
}

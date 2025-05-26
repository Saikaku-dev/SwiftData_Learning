//
//  ContentView.swift
//  iOS_SwiftData_Learning
//
//  Created by cmStudent on 2025/05/26.
//

import SwiftUI
import MapKit

struct MapView: View {
    @StateObject var vm = MapViewModel()
    @EnvironmentObject var route: NavigationRouter
    
    var body: some View {
            Map(position: $vm.cameraPostion) {
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
                            vm.selectedPlace = place
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
                vm.selectedPlace = nil
                if vm.shouldNavigateToAddReview {
                    route.navigate(to: .addReview)
                    vm.shouldNavigateToAddReview = false
                }
            }) {
                PlaceDetailSheet(vm: vm)
                    .presentationDetents([.fraction(0.5)])
            }
    }
}

#Preview {
    NavigationStack {
        MapView()
    }
}

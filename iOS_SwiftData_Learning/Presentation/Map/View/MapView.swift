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
                            // 使用自定义图片或默认图标
                            if let customImage = vm.getImageForPlace(place.id) {
                                Image(uiImage: customImage)
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .clipShape(Circle())
                                    .overlay(
                                        Circle()
                                            .stroke(Color.white, lineWidth: 2)
                                    )
                                    .shadow(radius: 3)
                            } else {
                                Image(systemName: "mappin.circle.fill")
                                    .font(.title)
                                    .foregroundColor(.red)
                                    .background(Color.white)
                                    .clipShape(Circle())
                            }
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

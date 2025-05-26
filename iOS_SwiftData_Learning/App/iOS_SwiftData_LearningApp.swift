//
//  iOS_SwiftData_LearningApp.swift
//  iOS_SwiftData_Learning
//
//  Created by cmStudent on 2025/05/26.
//

import SwiftUI

@main
struct iOS_SwiftData_LearningApp: App {
    @StateObject private var router = NavigationRouter()
    @StateObject private var vm = MapViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.path) {
                MapView()
                    .environmentObject(router)
                    .environmentObject(vm)
                    .navigationDestination(for: Route.self) { route in
                        switch route {
                        case .addReview:
                            if let selectedPlaceId = vm.selectedPlaceId {
                                AddReview(
                                    vm: AddReviewViewModel(
                                        mapViewModel: vm,
                                        placeId: selectedPlaceId
                                    )
                                )
                                .environmentObject(router)
                            } else {
                                Text("店舗が選択されていません")
                            }
                        }
                    }
            }
        }
    }
}

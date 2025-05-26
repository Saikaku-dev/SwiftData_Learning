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
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.path) {
                MapView()
                    .environmentObject(router)
                    .navigationDestination(for: Route.self) { route in
                        switch route {
                        case .addReview:
                            AddReview()
                                .environmentObject(router)
                        }
                    }
            }
        }
    }
}

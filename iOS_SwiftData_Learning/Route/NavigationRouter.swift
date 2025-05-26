//
//  NavigationRouter.swift
//  iOS_SwiftData_Learning
//
//  Created by cmStudent on 2025/05/26.
//


import SwiftUI

final class NavigationRouter: ObservableObject {
  @Published var path: [Route] = []

  func navigate(to route: Route) {
    path.append(route)
  }

  func pop() {
    path.removeLast()
  }

  func popToRoot() {
    path.removeAll()
  }

  func popUntil(_ predicate: (Route) -> Bool) {
    while let last = path.last, !predicate(last) {
      path.removeLast()
    }
  }
}

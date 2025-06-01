//
//  ReviewModeltest.swift
//  iOS_SwiftData_Learning
//
//  Created by cmStudent on 2025/06/01.
//

import Foundation
import SwiftUI

struct TestReviewModel {
    let id = UUID()
    let title: String
    let content: String
    let rating: Int
    let photoFileName: String?
    let createdAt: Date
}

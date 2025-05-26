//
//  ReviewCard.swift
//  iOS_SwiftData_Learning
//
//  Created by cmStudent on 2025/05/26.
//

import SwiftUI

struct ReviewCard: View {
    var body: some View {
        Text("まだレビューがありません")
            .foregroundColor(.secondary)
            .padding(.vertical, 16)
            .frame(maxWidth: .infinity, alignment: .center)
    }
}

#Preview {
    ReviewCard()
}

//
//  DetailHalfSheetView.swift
//  iOS_SwiftData_Learning
//
//  Created by cmStudent on 2025/06/01.
//

import SwiftUI

struct DetailHalfSheetView: View {
    var body: some View {
        // MARK: HEADER
        sheetHeader(title: "title", category: "category", action: {})
        Divider()
        // MARK: FOOTER
        reviewFormatter()
    }
}

extension View {
    func sheetHeader(title: String, category: String, action: @escaping(() -> Void)) -> some View {
        HStack {
            VStack(alignment: .leading) {
                Text(title)
                    .fontWeight(.bold)
                    .font(.title)
                Text(category)
                    .foregroundColor(.blue)
            }
            Spacer()
        }
        .overlay(alignment: .topTrailing) {
            Button(action: action) {
                Text("投稿")
                    .font(.title2)
            }
        }
        .padding()
    }
}

extension View {
    func reviewFormatter() -> some View {
        HStack(alignment: .top) {
            Rectangle()
                .frame(width: 80, height: 80)
                .cornerRadius(8)
            VStack(alignment: .leading) {
                Text("Title")
                Text("Message")
                    .foregroundColor(Color(.systemGray3))
            }
        }
    }
}
#Preview {
    DetailHalfSheetView()
}

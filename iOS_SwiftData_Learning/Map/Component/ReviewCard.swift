//
//  ReviewCard.swift
//  iOS_SwiftData_Learning
//
//  Created by cmStudent on 2025/05/26.
//

import SwiftUI

struct ReviewCard: View {
    let review: ReviewModel
    let vm: MapViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .top, spacing: 12) {
                if let fileName = review.photoFileName,
                   let photo = vm.loadImageFromDisk(fileName: fileName) {
                    Image(uiImage: photo)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 70, height: 70)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                        )
                        .shadow(radius: 1)
                }
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text(review.title)
                            .font(.headline)
                            .foregroundColor(.primary)
                        Spacer()
                        HStack(spacing: 1) {
                            ForEach(0..<5) { i in
                                Image(systemName: i < review.rating ? "star.fill" : "star")
                                    .foregroundColor(i < review.rating ? .yellow : .gray.opacity(0.4))
                                    .font(.caption)
                            }
                        }
                    }
                    Text(review.content)
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
            HStack {
                Spacer()
                Text(vm.dateString(review.createdAt))
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
        }
        .padding(14)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.systemBackground))
                .shadow(color: Color.black.opacity(0.06), radius: 4, x: 0, y: 2)
        )
        .frame(width: 320)
    }
}

#Preview {
    let review = ReviewModel(title: "美味しい！", content: "ラーメンがとても美味しかったです。店員さんも親切でした。", photoFileName: nil, rating: 4, createdAt: Date())
    ReviewCard(review: review, vm: MapViewModel())
}

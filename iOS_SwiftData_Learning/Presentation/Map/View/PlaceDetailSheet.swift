//
//  PlaceDetailSheet.swift
//  iOS_SwiftData_Learning
//
//  Created by cmStudent on 2025/05/26.
//

import SwiftUI

struct PlaceDetailSheet: View {
    @ObservedObject var vm: MapViewModel
    @EnvironmentObject var route: NavigationRouter
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            if let selectedPlaceId = vm.selectedPlaceId,
               let selectedPlace = vm.places.first(where: { $0.id == selectedPlaceId }) {
                
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(selectedPlace.name)
                            .font(.title2).bold()
                        HStack(spacing: 12) {
                            Text(selectedPlace.category)
                                .font(.subheadline)
                                .foregroundColor(.accentColor)
                        }
                    }
                    Spacer()
                }
                .overlay(alignment: .topTrailing) {
                    Button(action: {
                        dismiss()
                        vm.shouldAddReview = true
                    }) {
                        HStack(spacing: 0) {
                            Image(systemName: "plus.app")
                            Text("投稿")
                        }
                    }
                }
                Divider()
                    .padding(.vertical)
                
                if selectedPlace.reviews.isEmpty {
                    Text("レビューはまだありません")
                        .foregroundColor(.secondary)
                        .padding(.vertical, 16)
                        .frame(maxWidth: .infinity, alignment: .center)
                } else {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            ForEach(selectedPlace.reviews, id: \.id) { review in
                                ReviewCard(review: review, vm: vm)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                
            } else {
                Text("店舗を選択してください")
                    .foregroundColor(.secondary)
                    .padding(.vertical, 16)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
        }
        .padding()
    }
}

#Preview {
    PlaceDetailSheet(vm: MapViewModel())
}

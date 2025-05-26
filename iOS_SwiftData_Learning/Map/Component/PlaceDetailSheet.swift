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
            if let selectedPlace = vm.selectedPlace {
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
                    
                    Button(action: {
                        dismiss()
                        vm.shouldNavigateToAddReview = true
                    }) {
                        Text("投稿する")
                    }
                }
            } else {
                Text("店舗を選択してください")
                    .foregroundColor(.secondary)
                    .padding(.vertical, 16)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            
            Divider()
            
            Text("まだレビューがありません")
                .foregroundColor(.secondary)
                .padding(.vertical, 16)
                .frame(maxWidth: .infinity, alignment: .center)
            
        }
        .padding(.horizontal)
    }
}

#Preview {
    PlaceDetailSheet(vm: MapViewModel())
}

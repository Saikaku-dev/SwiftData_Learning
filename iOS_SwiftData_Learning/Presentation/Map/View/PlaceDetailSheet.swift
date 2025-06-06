import SwiftUI
import PhotosUI

struct PlaceDetailSheet: View {
    @ObservedObject var vm: MapViewModel
    @EnvironmentObject var route: NavigationRouter
    @Environment(\.dismiss) private var dismiss
    @State private var showingImageSourceActionSheet = false
    
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
                    VStack(alignment: .trailing, spacing: 8) {
                        Button(action: {
                            dismiss()
                            vm.shouldAddReview = true
                        }) {
                            HStack(alignment: .center, spacing: 2) {
                                Image(systemName: "plus.app")
                                Text("投稿")
                            }
                        }
                        Button(action: {
                            showingImageSourceActionSheet = true
                        }) {
                            HStack(alignment: .center, spacing: 2) {
                                Image(systemName: "photo")
                                Text("場所のアイコンを変更")
                            }
                        }
                    }
                }
                
                // 显示当前选中的图片（如果有）
                if let customImage = vm.getImageForPlace(selectedPlaceId) {
                    HStack {
                        Text("当前标注图片:")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Spacer()
                        Image(uiImage: customImage)
                            .resizable()
                            .frame(width: 40, height: 40)
                            .clipShape(Circle())
                    }
                    .padding(.vertical, 4)
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
        .confirmationDialog("选择图片来源", isPresented: $showingImageSourceActionSheet) {
            Button("相机") {
                vm.showCamera = true
            }
            Button("相册") {
                vm.showImagePicker = true
            }
            Button("取消", role: .cancel) { }
        }
        .sheet(isPresented: $vm.showImagePicker) {
            ImagePicker(sourceType: .photoLibrary) { image in
                if let placeId = vm.selectedPlaceId {
                    vm.setImageForPlace(image, placeId: placeId)
                }
            }
        }
        .sheet(isPresented: $vm.showCamera) {
            ImagePicker(sourceType: .camera) { image in
                if let placeId = vm.selectedPlaceId {
                    vm.setImageForPlace(image, placeId: placeId)
                }
            }
        }
    }
}

#Preview {
    PlaceDetailSheet(vm: MapViewModel())
}

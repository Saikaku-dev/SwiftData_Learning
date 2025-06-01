import SwiftUI

struct AddReviewView: View {
    @ObservedObject var vm: AddReviewViewModel
    @EnvironmentObject var router: NavigationRouter
    @Environment(\.dismiss) private var dismiss
    @FocusState private var focused: Bool
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // 地点信息
                    if let place = vm.currentPlace {
                        VStack(alignment: .leading, spacing: 8) {
                            Text(place.name)
                                .font(.title2)
                                .fontWeight(.bold)
                            Text(place.category)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                    }
                    
                    // 评分
                    VStack(alignment: .leading, spacing: 8) {
                        Text("評価")
                            .font(.headline)
                        HStack {
                            ForEach(1...5, id: \.self) { star in
                                Image(systemName: star <= vm.rating ? "star.fill" : "star")
                                    .foregroundColor(star <= vm.rating ? .yellow : .gray)
                                    .onTapGesture {
                                        vm.rating = star
                                    }
                            }
                        }
                    }
                    
                    // 标题
                    VStack(alignment: .leading, spacing: 8) {
                        Text("タイトル")
                            .font(.headline)
                        TextField("レビューのタイトルを入力", text: $vm.title)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .focused($focused)
                    }
                    
                    // 内容
                    VStack(alignment: .leading, spacing: 8) {
                        Text("内容")
                            .font(.headline)
                        TextEditor(text: $vm.content)
                            .frame(minHeight: 100)
                            .padding(8)
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                            .focused($focused)
                    }
                    
                    // 照片
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Text("写真")
                                .font(.headline)
                            Spacer()
                            Text("\(vm.photos.count)/3")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 12) {
                                // 添加照片按钮
                                if vm.photos.count < 3 {
                                    Menu {
                                        Button("カメラ") {
                                            vm.showCameraPicker = true
                                        }
                                        Button("フォトライブラリ") {
                                            vm.showImagePicker = true
                                        }
                                    } label: {
                                        RoundedRectangle(cornerRadius: 8)
                                            .fill(Color(.systemGray5))
                                            .frame(width: 80, height: 80)
                                            .overlay {
                                                Image(systemName: "plus")
                                                    .font(.title2)
                                                    .foregroundColor(.secondary)
                                            }
                                    }
                                }
                                
                                // 已选择的照片
                                ForEach(Array(vm.photos.enumerated()), id: \.offset) { index, photo in
                                    ZStack(alignment: .topTrailing) {
                                        Image(uiImage: photo)
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 80, height: 80)
                                            .clipped()
                                            .cornerRadius(8)
                                            .onTapGesture {
                                                if vm.selectedPhotoIndices.contains(index) {
                                                    vm.selectedPhotoIndices.remove(index)
                                                } else {
                                                    vm.selectedPhotoIndices.insert(index)
                                                }
                                            }
                                            .overlay {
                                                if vm.selectedPhotoIndices.contains(index) {
                                                    RoundedRectangle(cornerRadius: 8)
                                                        .fill(Color.blue.opacity(0.3))
                                                }
                                            }
                                        
                                        if vm.selectedPhotoIndices.contains(index) {
                                            Button {
                                                vm.selectedPhotoIndices.insert(index)
                                                vm.deleteSelectedPhotos()
                                            } label: {
                                                Image(systemName: "xmark.circle.fill")
                                                    .foregroundColor(.red)
                                                    .background(Color.white, in: Circle())
                                            }
                                            .offset(x: 5, y: -5)
                                        }
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                }
                .padding()
                .onTapGesture {
                    focused = false
                }
            }
            .navigationTitle("レビュー投稿")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("投稿") {
                        vm.saveReview()
                        router.goBack()
                    }
                    .disabled(!vm.isFormValid || vm.isLoading)
                }
            }
        }
        .sheet(isPresented: $vm.showImagePicker) {
            ImagePicker(selectedImage: { image in
                vm.addPhoto(image)
            })
        }
        .sheet(isPresented: $vm.showCameraPicker) {
            ImagePicker(sourceType: .camera, selectedImage: { image in
                vm.addPhoto(image)
            })
        }
    }
}

#Preview {
    AddReviewView(vm: AddReviewViewModel(
        mapViewModel: MapViewModel(),
        placeId: UUID()
    ))
}

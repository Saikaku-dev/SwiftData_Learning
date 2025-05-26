//
//  AddReview.swift
//  iOS_SwiftData_Learning
//
//  Created by cmStudent on 2025/05/26.
//

import SwiftUI
import PhotosUI

struct AddReview: View {
    @StateObject var vm = AddReviewViewModel()
    @FocusState private var focusedField: Field?
    enum Field { case title, content }
    @State private var imagePickerSource: UIImagePickerController.SourceType = .photoLibrary
    @State private var showPhotoSourceDialog: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "textformat")
                    .foregroundColor(.accentColor)
                TextField("タイトル", text: $vm.title)
                    .focused($focusedField, equals: .title)
            }
            .inputRowStyle()
            
            HStack(alignment: .top, spacing: 8) {
                Image(systemName: "doc.text")
                    .foregroundColor(.accentColor)
                    .padding(.top, 8)
                TextEditor(text: $vm.content)
                    .frame(height: 100)
                    .focused($focusedField, equals: .content)
            }
            .inputRowStyle()
            
            HStack(spacing: 4) {
                Text("評価：")
                    .font(.headline)
                ForEach(1...5, id: \ .self) { star in
                    Image(systemName: vm.rating >= star ? "star.fill" : "star")
                        .foregroundColor(.yellow)
                        .font(.title2)
                        .onTapGesture {
                            vm.rating = star
                        }
                }
            }
            
            if vm.photos.isEmpty {
                Button(action: {
                    showPhotoSourceDialog = true
                }) {
                    VStack {
                        Image(systemName: "plus.app")
                            .font(.system(size: 40))
                            .foregroundColor(.accentColor)
                        Text("写真を追加")
                            .foregroundColor(.accentColor)
                    }
                    .frame(maxWidth: .infinity, minHeight: 120)
                    .overlay(
                        RoundedRectangle(cornerRadius: 14)
                            .stroke(style: StrokeStyle(lineWidth: 2, dash: [8]))
                            .foregroundColor(Color.accentColor)
                    )
                    .confirmationDialog("写真の追加方法を選択", isPresented: $showPhotoSourceDialog, titleVisibility: .visible) {
                        Button("カメラで撮影") {
                            imagePickerSource = .camera
                            vm.showCameraPicker = true
                        }
                        Button("フォトライブラリから選択") {
                            imagePickerSource = .photoLibrary
                            vm.showImagePicker = true
                        }
                        Button("キャンセル", role: .cancel) {}
                    }
                }
                .padding(.vertical, 8)
            } else {
                Text("選択した写真：")
                    .font(.headline)
                    .padding(.leading, 4)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ForEach(Array(vm.photos.enumerated()), id: \ .offset) { index, image in
                            ZStack(alignment: .topTrailing) {
                                Image(uiImage: image)
                                    .resizable()
                                    .frame(width: 110, height: 110)
                                    .aspectRatio(contentMode: .fill)
                                    .background(Color(.systemGray6))
                                    .clipShape(RoundedRectangle(cornerRadius: 14))
                                    .shadow(radius: 2)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 14)
                                            .stroke(vm.selectedPhotoIndices.contains(index) ? Color.accentColor : Color.clear, lineWidth: 3)
                                    )
                                    .onTapGesture {
                                        if vm.selectedPhotoIndices.contains(index) {
                                            vm.selectedPhotoIndices.remove(index)
                                        } else {
                                            vm.selectedPhotoIndices.insert(index)
                                        }
                                    }
                                if vm.selectedPhotoIndices.contains(index) {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(.accentColor)
                                        .padding(6)
                                }
                            }
                        }
                    }
                    .padding(.vertical, 4)
                }
                Button(action: {
                    vm.deleteSelectedPhotos()
                }) {
                    Label("Delete Selected Photos", systemImage: "trash")
                        .foregroundColor(.white)
                        .padding(.vertical, 6)
                        .padding(.horizontal, 16)
                        .background(vm.selectedPhotoIndices.isEmpty ? Color(.systemGray3) : Color.red)
                        .cornerRadius(8)
                }
                .disabled(vm.selectedPhotoIndices.isEmpty)
                .padding(.leading, 4)
            }
            Button(action: {
                
            }) {
                Text("保存してアップロード")
            }
        }
        .fullScreenCover(isPresented: $vm.showCameraPicker) {
            ImagePicker(sourceType: .camera) { img in
                if let img = img {
                    vm.addPhoto(img)
                }
                vm.showCameraPicker = false
            }
            .ignoresSafeArea()
        }
        .sheet(isPresented: $vm.showImagePicker) {
            ImagePicker(sourceType: .photoLibrary) { img in
                if let img = img {
                    vm.addPhoto(img)
                }
            }
        }
        .onTapGesture {
            focusedField = nil
        }
    }
}

extension View {
    func inputRowStyle() -> some View {
        self
            .padding()
            .background()
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color(.systemGray5), lineWidth: 1)
            )
            .background(Color(.systemGray6))
            .cornerRadius(10)
            .shadow(color: Color(.systemGray4), radius: 2, x: 0, y: 1)
    }
}


#Preview {
    AddReview()
}

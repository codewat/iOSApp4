//
//  GalleryAndSettingsView.swift
//  iOSApp4
//
//  Created by Cemar on 2026-07-20.
//

import SwiftUI
import PhotosUI

struct GalleryAndSettingsView: View {
    @Binding var theme: ClinicTheme
    @State private var selectedItems = [PhotosPickerItem]()
    @State private var loadedImages = [UUID: Image]()
    
    var body: some View {
        VStack {
            Form {
                Section(header: Text("App Theme Settings")) {
                    Button("Switch to \(theme == .relaxingTeal ? "Classic Dark" : "Relaxing Teal") Mode") {
                        theme = (theme == .relaxingTeal) ? .classicDark : .relaxingTeal
                    }
                }
                
                Section(header: Text("Clinic Ambience Upload")) {
                    PhotosPicker(selection: $selectedItems, matching: .images) {
                        Label("Select Clinic Photos", systemImage: "photo.on.rectangle.angled")
                    }
                    .task(id: selectedItems) {
                        await loadGallery(from: selectedItems)
                    }
                }
            }
            
            if !loadedImages.isEmpty {
                ScrollView {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 10) {
                        ForEach(Array(loadedImages.keys), id: \.self) { key in
                            loadedImages[key]!
                                .resizable()
                                .scaledToFill()
                                .frame(width: 100, height: 100)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                    }
                    .padding()
                }
                .frame(height: 200)
            }
        }
        .navigationTitle("Settings & Gallery")
    }
    
    private func loadGallery(from items: [PhotosPickerItem]) async {
        for item in items {
            if let image = try? await item.loadTransferable(type: Image.self) {
                await MainActor.run {
                    loadedImages[UUID()] = image
                }
            }
        }
    }
}



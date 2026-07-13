//
//  AppointmentForm.swift
//  iOSApp4
//
//  Created by Cemar on 2026-07-13.
//

import SwiftUI
import PhotosUI

// ==========================================
// FEATURE 2: Form with Validation and Inputs
// ==========================================
struct AppointmentFormView: View {
    // Feature 4: Subscribing to the globally injected state manager
    @EnvironmentObject var clinicManager: ClinicManager
    
    // Local state variables for tracking text input values and UI presentation
    @State private var clientName = ""
    @State private var cellNumber = ""
    @State private var specialNotes = ""
    @State private var showingAlert = false
    
    var body: some View {
        Form {
            // Grouping personal details fields with a clear section header
            Section(header: Text("Client Information")) {
                TextField("Full Name", text: $clientName)
                
                TextField("Cell Number", text: $cellNumber)
                    .keyboardType(.phonePad) // Configures the keyboard specifically for typing phone numbers
            }
            
            // Optional section for user preferences
            Section(header: Text("Preferences")) {
                TextField("Special Instructions / Notes", text: $specialNotes)
            }
            
            // Submission action section
            Section {
                Button(action: {
                    if !clientName.isEmpty {
                        // Mutate global shared state by adding the newly registered appointment
                        clinicManager.appointments.append("\(clientName) - \(cellNumber)")
                        showingAlert = true
                    }
                }) {
                    Text("Confirm Booking")
                }
                // Form Validation check: prevents submission if mandatory fields are blank
                .disabled(clientName.isEmpty || cellNumber.isEmpty)
            }
            
            // Conditional view generation: displays the live booking list only when items exist
            if !clinicManager.appointments.isEmpty {
                Section(header: Text("Active Appointments This Session")) {
                    ForEach(clinicManager.appointments, id: \.self) { appt in
                        Text(appt)
                    }
                }
            }
        }
        .navigationTitle("New Appointment")
        // Native modal notification confirming success and resetting localized workspace attributes
        .alert("Success!", isPresented: $showingAlert) {
            Button("OK", role: .cancel) {
                clientName = ""
                cellNumber = ""
            }
        } message: {
            Text("Your massage therapy schedule has been reserved.")
        }
    }
}

// ===================================================
// FEATURE 5: Media Upload & Gallery (PhotosUI Integration)
// ===================================================
struct GalleryAndSettingsView: View {
    // Feature 3: Bi-directional binding referencing state declared in parent hierarchies
    @Binding var theme: ClinicTheme
    
    // Tracking selected photo stream items and processed structural SwiftUI images
    @State private var selectedItems = [PhotosPickerItem]()
    @State private var loadedImages = [UUID: Image]()
    
    var body: some View {
        VStack {
            Form {
                // Settings interface enabling environment configuration switches
                Section(header: Text("App Theme Settings")) {
                    Button("Switch to \(theme == .relaxingTeal ? "Classic Dark" : "Relaxing Teal") Mode") {
                        theme = (theme == .relaxingTeal) ? .classicDark : .relaxingTeal
                    }
                }
                
                // PhotosPicker component facilitating secure access to the iOS Photo Library
                Section(header: Text("Clinic Ambience Upload")) {
                    PhotosPicker(selection: $selectedItems, matching: .images) {
                        Label("Select Clinic Photos", systemImage: "photo.on.rectangle.angled")
                    }
                    // Listens to shifts in selection and executes the asynchronous loading process
                    .task(id: selectedItems) {
                        await loadGallery(from: selectedItems)
                    }
                }
            }
            
            // Renders the loaded photos using a flexible Grid Layout
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
    
    /// Parses high-level PhotosPickerItem assets asynchronously into renderable SwiftUI Image models.
    private func loadGallery(from items: [PhotosPickerItem]) async {
        for item in items {
            // Attempting to extract dynamic raw data streams conforming to the generic Image model
            if let image = try? await item.loadTransferable(type: Image.self) {
                // Bypassing main threads until operations complete, then thread-routing updates safely back to UI main actors
                await MainActor.run {
                    loadedImages[UUID()] = image
                }
            }
        }
    }
}

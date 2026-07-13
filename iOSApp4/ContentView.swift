//
//  ContentView.swift
//  iOSApp4
//
//  Created by Cemar on 2026-07-13.
//

import SwiftUI

struct ContentView: View {
    // Feature 4: Instantiating the single source of truth for global state management
    @StateObject private var clinicManager = ClinicManager()
    
    // Feature 1: Explicit path tracking array driving programmatic NavigationStack transitions
    @State private var navigationPath: [MassageService] = []
    
    // Local state managing global app styling context variations
    @State private var currentTheme: ClinicTheme = .relaxingTeal
    
    var body: some View {
        // NavigationStack bound to the path stream layout structure
        NavigationStack(path: $navigationPath) {
            List {
                // Section 1: Dynamic loop populating catalog rows from state variables
                Section(header: Text("Our Healing Services")) {
                    ForEach(clinicManager.sampleServices) { service in
                        // Passes a clean Hashable object type context downstream upon tap actions
                        NavigationLink(value: service) {
                            HStack {
                                Image(systemName: "heart.text.square.fill")
                                    .foregroundColor(.teal)
                                    .imageScale(.large)
                                VStack(alignment: .leading) {
                                    Text(service.name).font(.headline)
                                    Text(service.duration).font(.subheadline).foregroundColor(.gray)
                                }
                                Spacer()
                                Text(service.price).fontWeight(.semibold)
                            }
                        }
                    }
                }
                
                // Section 2: Standard destination-driven view routing paths
                Section(header: Text("Quick Actions")) {
                    NavigationLink(destination: AppointmentFormView()) {
                        Label("Book an Appointment", systemImage: "calendar.badge.plus")
                    }
                    NavigationLink(destination: GalleryAndSettingsView(theme: $currentTheme)) {
                        Label("Clinic Gallery & Settings", systemImage: "gearshape")
                    }
                }
            }
            .navigationTitle("Charlene's Clinic")
            // Feature 1: Decoupled programmatic endpoint tracking matching data models to target views
            .navigationDestination(for: MassageService.self) { service in
                ServiceDetailView(service: service)
            }
        }
        // Feature 4: Injecting global state down into the environment view hierachy tree
        .environmentObject(clinicManager)
        // Feature 3: Custom environment key data binding assignment propagation
        .environment(\.clinicTheme, currentTheme)
        // Adjusts system appearance layouts dynamically relative to selected user states
        .preferredColorScheme(currentTheme == .classicDark ? .dark : .light)
    }
}

// ==========================================
// FEATURE 1: Decoupled Functional Detail View
// ==========================================
struct ServiceDetailView: View {
    // Constant injection captured directly from path selections
    let service: MassageService
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(service.name)
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.teal)
            
            HStack {
                Label(service.duration, systemImage: "clock")
                Spacer()
                Label(service.price, systemImage: "tag")
            }
            .font(.headline)
            .padding(.vertical, 5)
            
            Text(service.description)
                .font(.body)
                .foregroundColor(.secondary)
            
            Spacer()
            
            // Context navigation forwarding workflow directly into transaction records forms
            NavigationLink(destination: AppointmentFormView()) {
                Text("Select this Service")
                    // Feature 6: Utilizing specialized re-usable view encapsulated design custom styling modifiers
                    .primaryButtonStyle()
            }
        }
        .padding()
        .navigationTitle("Details")
    }
}

#Preview {
    ContentView()
}

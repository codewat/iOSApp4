//
//  ContentView.swift
//  iOSApp4
//
//  Created by Cemar on 2026-07-13.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var clinicManager = ClinicManager()
    @State private var navigationPath: [MassageService] = []
    @State private var currentTheme: ClinicTheme = .relaxingTeal
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            List {
                Section(header: Text("Our Healing Services")) {
                    ForEach(clinicManager.filteredServices) { service in
                        NavigationLink(value: service) {
                            ServiceRowView(service: service) // Injected Refactored Subview
                        }
                    }
                }
                
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
            // Assignment 8 - Feature 6: Searchable API linked to state manager query strings
            .searchable(text: $clinicManager.searchText, prompt: "Search services...")
            .navigationDestination(for: MassageService.self) { service in
                ServiceDetailView(service: service)
            }
        }
        .environmentObject(clinicManager)
        .environment(\.clinicTheme, currentTheme)
        .preferredColorScheme(currentTheme == .classicDark ? .dark : .light)
    }
}

#Preview {
    ContentView()
}

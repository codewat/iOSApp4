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
                    ForEach(clinicManager.sampleServices) { service in
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
            .navigationDestination(for: MassageService.self) { service in
                ServiceDetailView(service: service)
            }
        }
        .environmentObject(clinicManager)
        .environment(\.clinicTheme, currentTheme)
        .preferredColorScheme(currentTheme == .classicDark ? .dark : .light)
    }
}

// Feature 1: Functional Detail View
struct ServiceDetailView: View {
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
            
            NavigationLink(destination: AppointmentFormView()) {
                Text("Select this Service")
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

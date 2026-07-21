//
//  ClinicManager.swift
//  iOSApp4
//
//  Created by Cemar on 2026-07-13.
//

import SwiftUI
import Combine

class ClinicManager: ObservableObject {
    // Assignment 8 - Feature 2: Persistent Storage using UserDefaults for Codable objects
    @Published var appointments: [Appointment] = [] {
        didSet {
            saveAppointments()
        }
    }
    
    @Published var searchText: String = "" // Used for Feature 4 (Searchable)
    
    let sampleServices = [
        MassageService(name: "Swedish Massage", duration: "60 mins", price: "₱600", description: "A relaxing full-body massage using long, gliding strokes."),
        MassageService(name: "Deep Tissue Massage", duration: "90 mins", price: "₱900", description: "Targets deep layers of muscle to release chronic tension."),
        MassageService(name: "Aromatherapy", duration: "60 mins", price: "₱750", description: "Uses essential oils to enhance physical and emotional well-being.")
    ]
    
    // Assignment 8 - Feature 4: Computed property to filter services dynamically
    var filteredServices: [MassageService] {
        if searchText.isEmpty {
            return sampleServices
        } else {
            return sampleServices.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    init() {
        loadAppointments()
    }
    
    private func saveAppointments() {
        if let encoded = try? JSONEncoder().encode(appointments) {
            UserDefaults.standard.set(encoded, forKey: "SavedAppointments")
        }
    }
    
    private func loadAppointments() {
        if let data = UserDefaults.standard.data(forKey: "SavedAppointments"),
           let decoded = try? JSONDecoder().decode([Appointment].self, from: data) {
            self.appointments = decoded
        }
    }
}

// ==========================================
// DATA MODEL: MassageService (Assignment 7 - Feature 1)
// ==========================================
struct MassageService: Hashable, Identifiable {
    var id: String { name }
    let name: String
    let duration: String
    let price: String
    let description: String
}

//
//  ClinicManager.swift
//  iOSApp4
//
//  Created by Cemar on 2026-07-13.
//

import SwiftUI  // Imported to ensure access to native SwiftUI properties, frameworks, and types
import Combine  // Imported to support the Combine framework's Publisher/Subscriber mechanics

// ==========================================
// DATA MODEL: MassageService
// ==========================================
/// A model representing a single massage service offered at the clinic.
/// Conforms to `Hashable` for secure list identification and `Identifiable` for simple dynamic loops.
struct MassageService: Hashable, Identifiable {
    // Unique identifier computed property required by the Identifiable protocol
    var id: String { name }
    
    let name: String
    let duration: String
    let price: String
    let description: String
}

// ==========================================
// FEATURE 4: Centralized Global State
// ==========================================
/// A shared data manager that holds the state of our active session's appointments.
/// By conforming to `ObservableObject`, any SwiftUI view listening to this class will automatically
/// reload whenever a `@Published` property changes.
class ClinicManager: ObservableObject {
    
    /// Dynamic array storing successfully booked appointment details.
    /// The `@Published` wrapper automatically broadcasts mutations to observing views.
    @Published var appointments: [String] = []
    
    /// Static collection of preset massage therapy options used to populate the main service catalog
    let sampleServices = [
        MassageService(
            name: "Swedish Massage",
            duration: "60 mins",
            price: "₱600",
            description: "A relaxing full-body massage using long, gliding strokes."
        ),
        MassageService(
            name: "Deep Tissue Massage",
            duration: "90 mins",
            price: "₱900",
            description: "Targets deep layers of muscle to release chronic tension."
        ),
        MassageService(
            name: "Aromatherapy",
            duration: "60 mins",
            price: "₱750",
            description: "Uses essential oils to enhance physical and emotional well-being."
        )
    ]
}

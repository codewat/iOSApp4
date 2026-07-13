//
//  ClinicManager.swift
//  iOSApp4
//
//  Created by Cemar on 2026-07-13.
//

import Foundation
import Combine

// Model for services in clinic
struct MassageService: Hashable, Identifiable {
    var id: String { name }
    let name: String
    let duration: String
    let price: String
    let description: String
}

// Global State (Feature 4)
class ClinicManager: ObservableObject {
    @Published var appointments: [String] = []
    
    let sampleServices = [
        MassageService(name: "Swedish Massage", duration: "60 mins", price: "₱600", description: "A relaxing full-body massage using long, gliding strokes."),
        MassageService(name: "Deep Tissue Massage", duration: "90 mins", price: "₱900", description: "Targets deep layers of muscle to release chronic tension."),
        MassageService(name: "Aromatherapy", duration: "60 mins", price: "₱750", description: "Uses essential oils to enhance physical and emotional well-being.")
    ]
}

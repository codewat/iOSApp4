//
//  Appointment.swift
//  iOSApp4
//
//  Created by Cemar on 2026-07-20.
//

import Foundation

// Assignment 8 - Feature 1: Structured Model using Identifiable and Codable
struct Appointment: Identifiable, Codable, Hashable {
    var id = UUID()
    let clientName: String
    let cellNumber: String
    let specialNotes: String
    let dateBooked: Date
}

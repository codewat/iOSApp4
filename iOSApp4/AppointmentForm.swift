//
//  AppointmentForm.swift
//  iOSApp4
//
//  Created by Cemar on 2026-07-13.
//

import SwiftUI
import PhotosUI

struct AppointmentFormView: View {
    @EnvironmentObject var clinicManager: ClinicManager
    
    @State private var clientName = ""
    @State private var cellNumber = ""
    @State private var specialNotes = ""
    @State private var showingAlert = false
    
    var body: some View {
        Form {
            Section(header: Text("Client Information")) {
                TextField("Full Name", text: $clientName)
                TextField("Cell Number", text: $cellNumber)
                    .keyboardType(.phonePad)
            }
            
            Section(header: Text("Preferences")) {
                TextField("Special Instructions / Notes", text: $specialNotes)
            }
            
            Section {
                Button(action: {
                    if !clientName.isEmpty {
                        // Creating structural object entity mapped to our custom persistent store model
                        let newAppointment = Appointment(
                            clientName: clientName,
                            cellNumber: cellNumber,
                            specialNotes: specialNotes,
                            dateBooked: Date()
                        )
                        clinicManager.appointments.append(newAppointment)
                        showingAlert = true
                    }
                }) {
                    Text("Confirm Booking")
                }
                .disabled(clientName.isEmpty || cellNumber.isEmpty)
            }
            
            if !clinicManager.appointments.isEmpty {
                Section(header: Text("Active Persistent Appointments")) {
                    ForEach(clinicManager.appointments) { appt in
                        VStack(alignment: .leading) {
                            Text(appt.clientName).font(.headline)
                            Text(appt.cellNumber).font(.subheadline).foregroundColor(.gray)
                            if !appt.specialNotes.isEmpty {
                                Text("\"\(appt.specialNotes)\"").font(.caption).italic().foregroundColor(.secondary)
                            }
                        }
                        // Assignment 8 - Feature 8: Swipe actions added to list rows for direct state deletion
                        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                            Button(role: .destructive) {
                                if let index = clinicManager.appointments.firstIndex(of: appt) {
                                    clinicManager.appointments.remove(at: index)
                                }
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle("New Appointment")
        .alert("Success!", isPresented: $showingAlert) {
            Button("OK", role: .cancel) {
                clientName = ""
                cellNumber = ""
                specialNotes = ""
            }
        } message: {
            Text("Your massage therapy schedule has been reserved.")
        }
    }
}

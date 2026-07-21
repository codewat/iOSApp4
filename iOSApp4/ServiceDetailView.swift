//
//  ServiceDetailView.swift
//  iOSApp4
//
//  Created by Cemar on 2026-07-20.
//

import SwiftUI

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
            
            // Assignment 8 - Feature 7: Integrated ShareLink to easily broadcast clinic info
            ShareLink(item: "I am looking at \(service.name) (\(service.duration) for \(service.price)) at Charlene's Clinic!") {
                Label("Share Service details", systemImage: "square.and.arrow.up")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.teal.opacity(0.2))
                    .cornerRadius(10)
            }
            .padding(.bottom, 5)
            
            NavigationLink(destination: AppointmentFormView()) {
                Text("Select this Service")
                    .primaryButtonStyle()
            }
        }
        .padding()
        .navigationTitle("Details")
    }
}

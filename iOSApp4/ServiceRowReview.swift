//
//  ServiceRowView.swift
//  iOSApp4
//
//  Created by Cemar on 2026-07-20.
//

import SwiftUI

// Assignment 8 - Feature 3: Refactored Subview Component for Better Maintainability
struct ServiceRowView: View {
    let service: MassageService
    
    var body: some View {
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
        // Assignment 8 - Feature 5: Context Menu for quick option peek/actions
        .contextMenu {
            ShareLink(item: "Check out \(service.name) at Charlene's Clinic for only \(service.price)!") {
                Label("Share Service Info", systemImage: "square.and.arrow.up")
            }
        }
    }
}

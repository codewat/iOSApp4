//
//  Theme.swift
//  iOSApp4
//
//  Created by Cemar on 2026-07-13.
//

import SwiftUI

// ==========================================
// FEATURE 3: Custom Environment Configuration
// ==========================================

/// An enumeration defining the distinct theme configurations available across the application context.
enum ClinicTheme {
    case relaxingTeal, classicDark
}

/// A custom structural key conforming to `EnvironmentKey` used to insert our custom theme configuration type into the system's Environment values.
struct ClinicThemeKey: EnvironmentKey {
    // The mandatory default value fallback required by the protocol
    static let defaultValue: ClinicTheme = .relaxingTeal
}

/// Extending the system's `EnvironmentValues` structure to provide a strongly-typed computed variable accessor for our custom key.
extension EnvironmentValues {
    var clinicTheme: ClinicTheme {
        get { self[ClinicThemeKey.self] }
        set { self[ClinicThemeKey.self] = newValue }
    }
}


// ==========================================================
// FEATURE 6: Encapsulated ViewModifier Layout Hierarchies
// ==========================================================

/// A reusable layout wrapper conforming to `ViewModifier` that encapsulates branding styles for application primary buttons.
struct PrimaryButtonModifier: ViewModifier {
    
    /// Modifies a given content view instance by appending modular layout layers, linear gradients, custom corner radii, and shadow styling.
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity) // Forces the modified view component to horizontally expand and fill its container
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [.teal, .blue]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .cornerRadius(12)
            .shadow(color: .gray.opacity(0.4), radius: 8, x: 0, y: 4)
    }
}

/// Extending the primitive `View` protocol to declare a clean, chainable modifier wrapper method.
extension View {
    /// Applies a uniform, professional layout signature to any target view item.
    func primaryButtonStyle() -> some View {
        self.modifier(PrimaryButtonModifier())
    }
}

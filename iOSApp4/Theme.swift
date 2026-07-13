//
//  Theme.swift
//  iOSApp4
//
//  Created by Cemar on 2026-07-13.
//

import SwiftUI

// Custom Environment Theme (Feature 3)
enum ClinicTheme {
    case relaxingTeal, classicDark
}

struct ClinicThemeKey: EnvironmentKey {
    static let defaultValue: ClinicTheme = .relaxingTeal
}

extension EnvironmentValues {
    var clinicTheme: ClinicTheme {
        get { self[ClinicThemeKey.self] }
        set { self[ClinicThemeKey.self] = newValue }
    }
}

// PrimaryButtonModifier (Feature 6)
struct PrimaryButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity)
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

extension View {
    func primaryButtonStyle() -> some View {
        self.modifier(PrimaryButtonModifier())
    }
}

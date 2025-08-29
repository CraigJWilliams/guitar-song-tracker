//
//  GuitarSongsTrackerApp.swift
//  GuitarSongsTracker
//
//  Created by Craig Williams on 27/08/2025.
//
import SwiftData
import SwiftUI

@main
struct GuitarSongsTrackerApp: App {
    @AppStorage("appearanceSetting") private var theme: String = "system"

    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(colorSchemeFrom(theme))
                .modelContainer(for: Song.self)
        }
    }

    func colorSchemeFrom(_ value: String) -> ColorScheme? {
        switch value {
        case "light":
            return .light
        case "dark":
            return .dark
        default:
            return nil
        }
    }
}

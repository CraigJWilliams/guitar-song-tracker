//
//  SettingsView.swift
//  GuitarSongsTracker
//
//  Created by Craig Williams on 29/08/2025.
//

import SwiftUI

struct SettingsView: View {

    @AppStorage("appearanceSetting") private var theme: String = "system"

    var body: some View {
        NavigationStack {
            Form {
                Picker("Appearance", selection: $theme) {
                    Text("System").tag("system")
                    Text("Light").tag("light")
                    Text("Dark").tag("dark")
                }
                .pickerStyle(.segmented)
            }
        }
        .navigationTitle("Settings")
    }
}


#Preview {
    SettingsView()
}

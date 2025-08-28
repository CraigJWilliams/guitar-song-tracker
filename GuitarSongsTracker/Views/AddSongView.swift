//
//  AddSongView.swift
//  GuitarSongsTracker
//
//  Created by Craig Williams on 28/08/2025.
//
import SwiftData
import SwiftUI

struct AddSongView: View {
    
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State var songTitle: String = ""
    @State var artistName: String = ""
    @State var songStatus: String = "Not Started"
    @State private var statuses = SongStatus.all
    
    private var canSave: Bool {
        !songTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        !artistName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Song Details") {
                    TextField("Song Title", text: $songTitle)
                        .textInputAutocapitalization(.words)
                    TextField("Artist Name", text: $artistName)
                        .textInputAutocapitalization(.words)
                }
                Section("Status") {
                    Picker("Status", selection: $songStatus) {
                        ForEach(statuses, id: \.self) { status in
                            Text(status).tag(status)
                        }
                    }.pickerStyle(.segmented)
                }
            }
            .navigationTitle("Add Song")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        let newSong = Song(title: songTitle, artist: artistName, status: songStatus)
                        modelContext.insert(newSong)
                        dismiss()
                    }
                    .disabled(!canSave)
                }
            }
        }
    }
}

#Preview {
    AddSongView()
}

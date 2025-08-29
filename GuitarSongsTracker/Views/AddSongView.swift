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

    @Binding var selectedSong: Song?
    
    @State var songTitle: String = ""
    @State var artistName: String = ""
    @State var songStatus: String = "Not Started"
    @State private var statuses = SongStatus.all

    private var songToEdit: Song?

    init(song: Song, selectedSong: Binding<Song?>) {
        self._selectedSong = selectedSong
        self.songToEdit = song
        _songTitle = State(initialValue: song.title)
        _artistName = State(initialValue: song.artist)
        _songStatus = State(initialValue: song.status)
    }

    init() {
        self._selectedSong = .constant(nil)
        self.songToEdit = nil
        _songTitle = State(initialValue: "")
        _artistName = State(initialValue: "")
        _songStatus = State(initialValue: "Not Started")
    }
    
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
            .navigationTitle(songToEdit == nil ? "Add Song" : "Edit Song")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        selectedSong = nil
                        dismiss()
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        if let songToEdit = songToEdit {
                            songToEdit.title = songTitle
                            songToEdit.artist = artistName
                            songToEdit.status = songStatus
                            selectedSong = nil
                        } else {
                            let newSong = Song(title: songTitle, artist: artistName, status: songStatus)
                            modelContext.insert(newSong)
                        }
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

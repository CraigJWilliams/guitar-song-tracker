//
//  ContentView.swift
//  GuitarSongsTracker
//
//  Created by Craig Williams on 27/08/2025.
//
import SwiftData
import SwiftUI

struct ContentView: View {
    
    @Query(sort: \Song.addedDate, order: .reverse) var songs: [Song]
    @Environment(\.modelContext) var modelContext
    
    @State private var selectedStatus = "All"
    @State private var statuses = ["All"] + SongStatus.all
    @State private var showingAlert = false
    @State private var songsToDelete: [Song] = []
    @State private var showSheet = false
    @State private var selectedSong: Song?
    
    var filteredSongs: [Song] {
        if selectedStatus == "All" {
            return songs
        } else {
            return songs.filter { $0.status == selectedStatus }
        }
    }
    
    var body: some View {
        NavigationStack {
            Picker("Filter" , selection: $selectedStatus) {
                ForEach(statuses, id: \.self) { status in
                    Text(status).tag(status)
                }
            }.pickerStyle(.segmented)
            
            List {
                ForEach(filteredSongs) { song in
                    SongListItem(song: song)
                        .onTapGesture {
                            selectedSong = song
                        }
                }
                .onDelete(perform: confirmDelete)
            }
            .navigationTitle("Song Tracker")
            .navigationSubtitle("\(filteredSongs.count) \(filteredSongs.count == 1 ? "Song" : "Songs")")
            .toolbar {
                ToolbarItem (placement: .topBarTrailing) {
                    NavigationLink(destination: SettingsView()) {
                        Label("Settings", systemImage: "gear")
                            .font(.title2)
                            .labelStyle(.iconOnly)
                    }
                }
                ToolbarItem(placement: .bottomBar) {
                    Spacer()
                }
                ToolbarItem (placement: .bottomBar) {
                    Button {
                        showSheet = true
                        selectedSong = nil
                    } label: {
                        Label("Add Song", systemImage: "plus")
                    }.buttonStyle(.glassProminent)
                        .tint(.indigo)
                }
            }
        }
        .sheet(item: $selectedSong) { song in
            AddSongView(song: song, selectedSong: $selectedSong)
        }
        .sheet(isPresented: $showSheet) {
            AddSongView()
        }
        .alert(songsToDelete.count == 1 ? "Delete song?" : "Delete \(songsToDelete.count) songs?", isPresented: $showingAlert) {
            Button("Delete", role: .destructive) {
                for song in songsToDelete {
                    modelContext.delete(song)
                }
                songsToDelete = []
            }
            Button("Cancel", role: .cancel) {
                songsToDelete = []
            }
        } message: {
            Text("This action cannot be undone.")
        }
    }
    
    //MARK: - FUNCTIONS
    
    func confirmDelete(at offsets: IndexSet) {
        songsToDelete = offsets.map { filteredSongs[$0] }
        showingAlert = true
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Song.self, inMemory: true)
}

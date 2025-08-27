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
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(songs) { song in
                    SongListItem(song: song)
                }
            }            .navigationTitle("Song Tracker")
                .navigationSubtitle("\(songs.count) \(songs.count == 1 ? "song" : "songs") tracked")
                .toolbar {
                    ToolbarItem {
                        Button {
                            addDummyData()
                        } label: {
                            Label("Add Song", systemImage: "plus")
                        }
                    }
                }
        }
    }
    
    private func addDummyData() {
        let dummySongs = [
            Song(title: "Wonderwall",
                 artist: "Oasis",
                 status: "Learning"),
            Song(title: "Hotel California",
                 artist: "Eagles",
                 status: "Not Started"),
            Song(title: "Sweet Child O' Mine",
                 artist: "Guns N' Roses",
                 status: "Mastered"),
            Song(title: "Black",
                 artist: "Pearl Jam",
                 status: "Mastered"),
            Song(title: "Stairway to Heaven",
                 artist: "Led Zeppelin",
                 status: "Not Started"),
            Song(title: "Creep",
                 artist: "Radiohead",
                 status: "Learning"),
            Song(title: "Wish You Were Here",
                 artist: "Pink Floyd",
                 status: "Mastered"),
            Song(title: "Under the Bridge",
                 artist: "Red Hot Chili Peppers",
                 status: "Learning")
        ]
        
        for song in dummySongs {
            modelContext.insert(song)
        }
    }
}

struct SongListItem: View {
    let song: Song
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(song.artist)
                .font(.caption)
            Text(song.title)
                .font(.title2)
                .bold()
                .padding(.bottom, 4)
            Text(song.status)
                .font(.footnote)
                .bold()
                .foregroundColor(.secondary)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(statusColor(for: song.status))
                .cornerRadius(16)
        }
        .padding(.vertical, 2)
        .lineLimit(1)
        .truncationMode(.tail)
    }
    private func statusColor(for status: String) -> Color {
        switch status {
        case "Not Started": return .red.opacity(0.2)
        case "Learning": return .orange.opacity(0.2)
        case "Mastered": return .green.opacity(0.2)
        default: return .gray.opacity(0.2)
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Song.self, inMemory: true)
}

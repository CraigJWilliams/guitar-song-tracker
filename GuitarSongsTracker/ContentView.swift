//
//  ContentView.swift
//  GuitarSongsTracker
//
//  Created by Craig Williams on 27/08/2025.
//
import SwiftData
import SwiftUI

struct ContentView: View {
    
    @Query var songs: [Song]
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(songs) { song in
                    // TODO: Refactor list items into separate SongRowView struct
                    VStack(alignment: .leading, spacing: 4) {
                        Text(song.title)
                            .font(.title2)
                        Text(song.artist)
                            .font(.title3)
                        Text(song.status)
                            .font(.body)
                        Text(song.addedDate.formatted(date: .abbreviated, time: .omitted))
                    }.padding(.vertical, 4)
                }
            }
            .navigationTitle("Song Tracker")
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
                 status: "Can Play"),
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
                 status: "Can Play"),
            Song(title: "Under the Bridge",
                 artist: "Red Hot Chili Peppers",
                 status: "Learning")
        ]
        
        for song in dummySongs {
            modelContext.insert(song)
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Song.self, inMemory: true)
}

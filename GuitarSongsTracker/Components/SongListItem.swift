//
//  SongListItem.swift
//  GuitarSongsTracker
//
//  Created by Craig Williams on 28/08/2025.
//

import SwiftUI

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
    SongListItem(song: Song(title: "Sample Song", artist: "Sample Artist", status: "Learning"))
}

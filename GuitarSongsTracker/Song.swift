//
//  Song.swift
//  GuitarSongsTracker
//
//  Created by Craig Williams on 27/08/2025.
//

import Foundation
import SwiftData

@Model
class Song {
    var title: String
    var artist: String
    var status: String
    var addedDate: Date

    init(title: String, artist: String, status: String, addedDate: Date = .now) {
        self.title = title
        self.artist = artist
        self.status = status
        self.addedDate = addedDate
    }
}

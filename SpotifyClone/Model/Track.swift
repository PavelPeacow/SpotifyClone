//
//  Track.swift
//  SpotifyClone
//
//  Created by Павел Кай on 30.01.2023.
//

import Foundation

// MARK: - Track
struct Track: Decodable {
    let album: Album?
    let artists: [AddedBy]?
    let availableMarkets: [String]?
    let discNumber, durationMS: Int?
    let episode, explicit: Bool?
    let href: String?
    let id: String?
    let isLocal: Bool?
    let name: String?
    let popularity: Int?
    let previewURL: String?
    let track: Bool?
    let trackNumber: Int?
    let type: String?
    let uri: String?

    enum CodingKeys: String, CodingKey {
        case album, artists
        case availableMarkets = "available_markets"
        case discNumber = "disc_number"
        case durationMS = "duration_ms"
        case episode, explicit
        case href, id
        case isLocal = "is_local"
        case name, popularity
        case previewURL = "preview_url"
        case track
        case trackNumber = "track_number"
        case type, uri
    }
}

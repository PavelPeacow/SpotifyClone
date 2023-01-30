//
//  Album.swift
//  SpotifyClone
//
//  Created by Павел Кай on 30.01.2023.
//

import Foundation

// MARK: - RecentlyPlayed
struct AlbumContent: Decodable {
    let albumType: String?
    let artists: [Artist]?
    let availableMarkets: [String]?
    let copyrights: [Copyright]?
    let externalIDS: ExternalIDS?
    let externalUrls: ExternalUrls?
    let href: String?
    let id: String?
    let images: [Image]?
    let label, name: String?
    let popularity: Int?
    let releaseDate, releaseDatePrecision: String?
    let totalTracks: Int?
    let tracks: Tracks?
    let type, uri: String?

    enum CodingKeys: String, CodingKey {
        case albumType = "album_type"
        case artists
        case availableMarkets = "available_markets"
        case copyrights
        case externalIDS = "external_ids"
        case externalUrls = "external_urls"
        case href, id, images, label, name, popularity
        case releaseDate = "release_date"
        case releaseDatePrecision = "release_date_precision"
        case totalTracks = "total_tracks"
        case tracks, type, uri
    }
}

// MARK: - ExternalIDS
struct ExternalIDS: Codable {
    let upc: String
}


// MARK: - Item
struct AlbumItem: Decodable {
    let artists: [Artist]?
    let availableMarkets: [String]?
    let discNumber, durationMS: Int?
    let explicit: Bool?
    let externalUrls: ExternalUrls?
    let href: String?
    let id: String?
    let isLocal: Bool?
    let name: String?
    let previewURL: String?
    let trackNumber: Int?
    let type: String?
    let uri: String?

    enum CodingKeys: String, CodingKey {
        case artists
        case availableMarkets = "available_markets"
        case discNumber = "disc_number"
        case durationMS = "duration_ms"
        case explicit
        case externalUrls = "external_urls"
        case href, id
        case isLocal = "is_local"
        case name
        case previewURL = "preview_url"
        case trackNumber = "track_number"
        case type, uri
    }
}

//
//  Album.swift
//  SpotifyClone
//
//  Created by Павел Кай on 30.01.2023.
//

import Foundation

struct Album: Decodable {
    let albumType: String?
    let artists: [Artist]?
    let availableMarkets: [String]?
    let copyrights: [Copyright]?
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
        case href, id, images, label, name, popularity
        case releaseDate = "release_date"
        case releaseDatePrecision = "release_date_precision"
        case totalTracks = "total_tracks"
        case tracks, type, uri
    }
}

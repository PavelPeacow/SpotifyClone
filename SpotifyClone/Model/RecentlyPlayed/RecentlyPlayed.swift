//
//  RecentlyPlayed.swift
//  SpotifyClone
//
//  Created by Павел Кай on 30.01.2023.
//

import Foundation

// MARK: - RecentlyPlayed
struct RecentlyPlayed: Decodable {
    let items: [RecentlyPlayedItem]
    let next: String?
    let limit: Int
    let href: String
}

// MARK: - Item
struct RecentlyPlayedItem: Decodable {
    let track: Track
    let playedAt: String

    enum CodingKeys: String, CodingKey {
        case track
        case playedAt = "played_at"
    }
}

// MARK: - ExternalUrls
struct ExternalUrls: Codable {
    let spotify: String
}

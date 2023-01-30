//
//  CurrentUserAlbums.swift
//  SpotifyClone
//
//  Created by Павел Кай on 28.01.2023.
//

import Foundation

// MARK: - CurrentUserAlbums
struct CurrentUserAlbums: Decodable {
    let href: String
    let items: [CurrentUserAlbumsItem]
    let limit: Int
    let offset: Int
    let total: Int
    

}

// MARK: - CurrentUserAlbumsItem
struct CurrentUserAlbumsItem: Decodable {
    let addedAt: String
    let album: Album

    enum CodingKeys: String, CodingKey {
        case addedAt = "added_at"
        case album
    }
}

// MARK: - Copyright
struct Copyright: Decodable {
    let text: String
    let type: String
}

// MARK: - Tracks
struct Tracks: Decodable {
    let href: String
    let items: [Track]
    let limit: Int
    let offset: Int
    let total: Int
}

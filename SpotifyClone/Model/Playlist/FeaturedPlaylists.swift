//
//  FeaturedPlaylists.swift
//  SpotifyClone
//
//  Created by Павел Кай on 27.01.2023.
//

import Foundation

// MARK: - FeaturedPlaylists
struct FeaturedPlaylists: Decodable {
    let message: String
    let playlists: Playlists
    
}

// MARK: - Playlists
struct Playlists: Decodable {
    let href: String
    let items: [PlaylistItem]
    let limit: Int
    let offset: Int
    let total: Int
}

// MARK: - Item
struct PlaylistItem: Decodable {
    let collaborative: Bool
    let description: String
    let href: String
    let id: String
    let images: [Image]
    let name: String
    let owner: Owner
    let snapshotID: String
    let type: String
    let uri: String

    enum CodingKeys: String, CodingKey {
        case collaborative, description
        case href, id, images, name, owner
        case snapshotID = "snapshot_id"
        case type, uri
    }
}

// MARK: - Owner
struct Owner: Decodable {
    let displayName: String
    let href: String
    let id: String
    let type: String
    let uri: String

    enum CodingKeys: String, CodingKey {
        case displayName = "display_name"
        case href, id, type, uri
    }
}

//
//  PlaylistContent.swift
//  SpotifyClone
//
//  Created by Павел Кай on 29.01.2023.
//

import Foundation

// MARK: - PlaylistContent
struct PlaylistContent: Decodable {
    let href: String
    let items: [PlaylistContentItem]
    let limit: Int
    let offset: Int
    let total: Int
}

// MARK: - Item
struct PlaylistContentItem: Decodable {
    let addedAt: String
    let addedBy: AddedBy
    let isLocal: Bool
    let track: Track

    enum CodingKeys: String, CodingKey {
        case addedAt = "added_at"
        case addedBy = "added_by"
        case isLocal = "is_local"
        case track
    }
}

// MARK: - AddedBy
struct AddedBy: Decodable {
    let href: String
    let id: String
    let type: String
    let uri: String
    let name: String?

    enum CodingKeys: String, CodingKey {
        case href, id, type, uri, name
    }
}

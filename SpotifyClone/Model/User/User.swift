//
//  User.swift
//  SpotifyClone
//
//  Created by Павел Кай on 03.03.2023.
//

import Foundation

// MARK: - User
struct User: Decodable {
    let displayName: String?
    let externalUrls: ExternalUrls?
    let followers: Followers?
    let href: String?
    let id: String?
    let images: [Image]?
    let type, uri: String?

    enum CodingKeys: String, CodingKey {
        case displayName = "display_name"
        case externalUrls = "external_urls"
        case followers, href, id, images, type, uri
    }
}

// MARK: - Followers
struct Followers: Codable {
    let href: String?
    let total: Int?
}

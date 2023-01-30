//
//  Artist.swift
//  SpotifyClone
//
//  Created by Павел Кай on 30.01.2023.
//

import Foundation

// MARK: - Artist
struct Artist: Decodable {
    let href: String?
    let id: String?
    let name: String?
    let type: String?
    let uri: String?

    enum CodingKeys: String, CodingKey {
        case href, id, name, type, uri
    }
}

//
//  SearchResponce.swift
//  SpotifyClone
//
//  Created by Павел Кай on 12.03.2023.
//

import Foundation

// MARK: - SearchResponse
struct SearchResponse: Decodable {
    let albums: Albums
    let artists: Artists
    let tracks: Tracks
}

// MARK: - Albums
struct Albums: Decodable {
    let href: String
    let items: [Album]
    let limit: Int
    let next: String
    let offset: Int
    let previous: String?
    let total: Int
}

struct Artists: Decodable {
    let href: String
    let items: [Artist]
    let limit: Int
    let next: String
    let offset: Int
    let previous: String?
    let total: Int
}

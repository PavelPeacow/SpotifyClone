//
//  FeaturedPlaylists.swift
//  SpotifyClone
//
//  Created by Павел Кай on 27.01.2023.
//

import Foundation

struct FeaturedPlaylistsResponse: Decodable {
    let message: String
    let playlists: FeaturedPlaylistsItems
}

struct FeaturedPlaylistsItems: Decodable {
    let href: String?
    let items: [FeaturedPlaylist]
}

struct FeaturedPlaylist: Decodable {
    let name: String?
    let images: [Image]
}

struct Image: Decodable {
    let url: String?
}

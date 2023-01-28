//
//  UserAlbum.swift
//  SpotifyClone
//
//  Created by Павел Кай on 28.01.2023.
//

import Foundation

struct UserAlbumItems: Decodable {
    let items: [UserAlbum]
}

struct UserAlbum: Decodable {
    let album: AlbumContent
}

struct AlbumContent: Decodable {
    let label: String
    let name: String
    let images: [Image]
    let id: String
}

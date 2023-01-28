//
//  NewReleaseAlbum.swift
//  SpotifyClone
//
//  Created by Павел Кай on 28.01.2023.
//

import Foundation

struct NewAlbumReleaseResponse: Decodable {
    let albums: NewAlbumRelease
}

struct NewAlbumRelease: Decodable {
    let items: [NewAlbumContent]
}

struct NewAlbumContent: Decodable {
    let name: String?
    let images: [Image]
}

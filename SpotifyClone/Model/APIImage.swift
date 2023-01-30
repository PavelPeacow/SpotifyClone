//
//  APIImage.swift
//  SpotifyClone
//
//  Created by Павел Кай on 30.01.2023.
//

import Foundation

// MARK: - Image
struct Image: Decodable {
    let height: Int?
    let url: String
    let width: Int?
}

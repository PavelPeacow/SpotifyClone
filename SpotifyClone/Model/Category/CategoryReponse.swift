//
//  CategoryReponse.swift
//  SpotifyClone
//
//  Created by Павел Кай on 11.03.2023.
//

import Foundation

// MARK: - CategoriesResponse
struct CategoriesResponse: Decodable {
    let categories: Categories
}

// MARK: - Categories
struct Categories: Decodable {
    let href: String
    let items: [CategoriesItem]
    let limit: Int
    let next: String
    let offset: Int
    let previous: String?
    let total: Int
}

// MARK: - Item
struct CategoriesItem: Decodable {
    let href: String
    let icons: [Image]
    let id, name: String
}

//// MARK: - Icon
//struct Icon: Codable {
//    let height: Int?
//    let url: String
//    let width: Int?
//}

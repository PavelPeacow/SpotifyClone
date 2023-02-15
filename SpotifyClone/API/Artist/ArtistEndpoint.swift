//
//  ArtistEndpoint.swift
//  SpotifyClone
//
//  Created by Павел Кай on 14.02.2023.
//

import Foundation

enum ArtistEndpoint: Endpoint {
    case getArtist(id: String)
    case getArtistAlbums(id: String)
    case getArtistTopTracks(id: String)
    
    var httpMethod: String {
        switch self {
            
        case .getArtist, .getArtistAlbums, .getArtistTopTracks:
            return "GET"
        }
    }
    
    func urlComponents(scheme: String = "https", host: String = "api.spotify.com", path: String, queryItems: [URLQueryItem]?) -> URL? {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path
        components.queryItems = queryItems
        return components.url
    }
    
    var url: URL? {
        switch self {
            
        case .getArtist(id: let id):
            return urlComponents(path: "/v1/artists/\(id)", queryItems: nil)
        case .getArtistAlbums(id: let id):
            let queryItems = [
                URLQueryItem(name: "country", value: "PL")
            ]
            return urlComponents(path: "/v1/artists/\(id)/albums", queryItems: queryItems)
        case .getArtistTopTracks(id: let id):
            let queryItems = [
                URLQueryItem(name: "country", value: "PL")
            ]
            return urlComponents(path: "/v1/artists/\(id)/top-tracks", queryItems: queryItems)
        }
    }
    
    func getRequest(url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        print(url)
        switch self {
        case .getArtist, .getArtistAlbums, .getArtistTopTracks:
            request.httpMethod = httpMethod
            request.setValue("Bearer \(Token.shared.token ?? "")", forHTTPHeaderField: "Authorization")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            return request
        }
    }
}

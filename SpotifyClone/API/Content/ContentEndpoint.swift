//
//  ContentEndpoint.swift
//  SpotifyClone
//
//  Created by Павел Кай on 28.01.2023.
//

import Foundation

enum ContentEndpoint: Endpoint {
    case getFeaturedPlaylists
    case getUserAlbum
    case getNewReleases
    
    var httpMethod: String {
        switch self {
        case .getFeaturedPlaylists, .getUserAlbum, .getNewReleases:
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
            
        case .getFeaturedPlaylists:
            let queryItems = [
                URLQueryItem(name: "country", value: "PL")
            ]
            return urlComponents(path: "/v1/browse/featured-playlists", queryItems: queryItems)
        case .getUserAlbum:
            let queryItems = [
                URLQueryItem(name: "market", value: "PL")
            ]
            return urlComponents(path: "/v1/me/albums", queryItems: queryItems)
        case .getNewReleases:
            let queryItems = [
                URLQueryItem(name: "country", value: "PL")
            ]
            return urlComponents(path: "/v1/browse/new-releases", queryItems: queryItems)
        }
    }
            
    func getRequest(url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        print(url)
     
        switch self {
        case .getFeaturedPlaylists, .getUserAlbum, .getNewReleases:
            request.httpMethod = httpMethod
            request.setValue("Bearer \(Token.token ?? "")", forHTTPHeaderField: "Authorization")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            return request
        }
    }
    
}

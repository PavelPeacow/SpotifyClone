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
    
    case getPlaylistContent(playlistID: String)
    case getAlbumContent(albumID: String)
    
    var httpMethod: String {
        switch self {
        case .getFeaturedPlaylists, .getUserAlbum, .getPlaylistContent, .getAlbumContent:
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
        case .getPlaylistContent(let playlistID):
            let queryItems = [
                URLQueryItem(name: "country", value: "PL")
            ]
            return urlComponents(path: "/v1/playlists/\(playlistID)/tracks", queryItems: queryItems)
        case .getAlbumContent(albumID: let albumID):
            let queryItems = [
                URLQueryItem(name: "country", value: "PL")
            ]
            return urlComponents(path: "/v1/albums/\(albumID)/tracks", queryItems: queryItems)
        }
    }
            
    func getRequest(url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        print(url)
     
        switch self {
        case .getFeaturedPlaylists, .getUserAlbum, .getPlaylistContent, .getAlbumContent:
            request.httpMethod = httpMethod
            request.setValue("Bearer \(Token.token ?? "")", forHTTPHeaderField: "Authorization")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            return request
        }
    }
    
}

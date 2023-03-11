//
//  CategoryEndpoint.swift
//  SpotifyClone
//
//  Created by Павел Кай on 11.03.2023.
//

import Foundation

enum CategoryEndpoint: Endpoint {
    case getCategories
    case getCategoryPlaylists(categoryId: String, limit: String)
    
    var httpMethod: String {
        "GET"
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
            
        case .getCategories:
            let query = [
                URLQueryItem(name: "country", value: "PL"),
                URLQueryItem(name: "limit", value: "40"),
            ]
            
            return urlComponents(path: "/v1/browse/categories", queryItems: query)
        case .getCategoryPlaylists(categoryId: let id, limit: let limit):
            let query = [
                URLQueryItem(name: "country", value: "US"),
                URLQueryItem(name: "limit", value: limit),
            ]
            
            return urlComponents(path: "/v1/browse/categories/\(id)/playlists", queryItems: query)
        }
       
    }
    
    func getRequest(url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        
        request.httpMethod = httpMethod
        request.setValue("Bearer \(Token.shared.token ?? "")", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
    
}

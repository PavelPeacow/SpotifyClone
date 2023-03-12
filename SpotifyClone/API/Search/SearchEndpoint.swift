//
//  SearchEndpoint.swift
//  SpotifyClone
//
//  Created by Павел Кай on 12.03.2023.
//

import UIKit

enum SearchEndpoint: Endpoint {
    case search(query: String, type: String)
    
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
            
        case .search(query: let query, type: let type):
            let query = [
                URLQueryItem(name: "q", value: query),
                URLQueryItem(name: "type", value: type),
            ]
            
            return urlComponents(path: "/v1/search", queryItems: query)
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

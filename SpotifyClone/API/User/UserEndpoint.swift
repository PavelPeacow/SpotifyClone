//
//  UserEndpoint.swift
//  SpotifyClone
//
//  Created by Павел Кай on 03.03.2023.
//

import Foundation

enum UserEndpoint: Endpoint {
    case getUser(id: String)
    
    var httpMethod: String {
        switch self {
            
        case .getUser:
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
        case .getUser(id: let id):
            return urlComponents(path: "/v1/users/\(id)", queryItems: nil)
        }
    }
    
    func getRequest(url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        
        switch self {
        case .getUser:
            request.httpMethod = httpMethod
            request.setValue("Bearer \(Token.shared.token ?? "")", forHTTPHeaderField: "Authorization")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            return request
        }
        
    }
    
    
}

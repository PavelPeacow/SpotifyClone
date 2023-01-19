//
//  APIEndpoint.swift
//  SpotifyClone
//
//  Created by Павел Кай on 19.01.2023.
//

import Foundation

enum APIEndpoint {
    case getCode
    case exchangeCodeForToken(code: String)
   
    var url: URL? {
        switch self {
            
        case .exchangeCodeForToken(let code):
            
            let queryItems = [
                URLQueryItem(name: "grant_type", value: "authorization_code"),
                URLQueryItem(name: "code", value: code),
                URLQueryItem(name: "redirect_uri", value: APIConstant.redirect_uri)
            ]
            
            return urlComponents(host: "accounts.spotify.com", path: "/api/token", queryItems: queryItems)
            
        case .getCode:
            let queryItems = [
                URLQueryItem(name: "client_id", value: APIConstant.clientID),
                URLQueryItem(name: "response_type", value: "code"),
                URLQueryItem(name: "redirect_uri", value: APIConstant.redirect_uri)
            ]
            
            return urlComponents(host: "accounts.spotify.com", path: "/authorize", queryItems: queryItems)
        }
    }
        
    private func urlComponents(scheme: String = "https", host: String = "api.spotify.com", path: String, queryItems: [URLQueryItem]?) -> URL? {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path
        components.queryItems = queryItems
        return components.url
    }
    
    private var httpMethod: String {
        switch self {
            
        case .exchangeCodeForToken:
            return "POST"
        case .getCode:
            return "GET"
        }
    }
    
    func getRequest(url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        print(url)
        switch self {
            
        case .exchangeCodeForToken:
            let value = APIConstant.clientID + ":" + APIConstant.clientSecret
            request.httpMethod = httpMethod
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.setValue("Basic \(value.encodeToBase64())", forHTTPHeaderField: "Authorization")
        case .getCode:
            return request
        }

        return request
    }
}

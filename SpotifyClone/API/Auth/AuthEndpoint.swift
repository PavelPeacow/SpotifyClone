//
//  APIEndpoint.swift
//  SpotifyClone
//
//  Created by Павел Кай on 19.01.2023.
//

import Foundation

protocol Endpoint {
    var httpMethod: String { get }
    func urlComponents(scheme: String, host: String, path: String, queryItems: [URLQueryItem]?) -> URL?
    var url: URL? { get }
    func getRequest(url: URL) -> URLRequest
}

enum AuthEndpoint: Endpoint {
    case getCode
    case exchangeCodeForToken(code: String)
    case getRefreshToken(token: String)
    
    var httpMethod: String {
        switch self {
            
        case .exchangeCodeForToken, .getRefreshToken:
            return "POST"
        case .getCode:
            return "GET"
        }
    }
    
    func urlComponents(scheme: String = "https", host: String = "accounts.spotify.com", path: String, queryItems: [URLQueryItem]?) -> URL? {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path
        components.queryItems = queryItems
        return components.url
    }
    
    var url: URL? {
        switch self {
            
        case .exchangeCodeForToken(let code):
            
            let queryItems = [
                URLQueryItem(name: "grant_type", value: "authorization_code"),
                URLQueryItem(name: "code", value: code),
                URLQueryItem(name: "redirect_uri", value: APIConstant.redirect_uri)
            ]
            
            return urlComponents(path: "/api/token", queryItems: queryItems)
            
        case .getCode:
            let queryItems = [
                URLQueryItem(name: "client_id", value: APIConstant.clientID),
                URLQueryItem(name: "response_type", value: "code"),
                URLQueryItem(name: "redirect_uri", value: APIConstant.redirect_uri),
                URLQueryItem(name: "scope", value: "user-library-read user-read-recently-played")
            ]
            
            return urlComponents(path: "/authorize", queryItems: queryItems)
            
        case .getRefreshToken(let token):
            let queryItems = [
                URLQueryItem(name: "grant_type", value: "refresh_token"),
                URLQueryItem(name: "refresh_token", value: token)
            ]
            
            return urlComponents(path: "/api/token", queryItems: queryItems)
        }
    }
    
    func getRequest(url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        print(url)
        switch self {
            
        case .exchangeCodeForToken, .getRefreshToken:
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

//
//  APIManager.swift
//  SpotifyClone
//
//  Created by Павел Кай on 19.01.2023.
//

import Foundation

protocol APIManagerProtocol {
    func getSpotifyContent<T: Decodable>(type: T.Type, endpoint: APIEndpoint) async throws -> T
}

fileprivate enum APIError: Error {
    case badURl
    case cannotGet
    case cannotDecode
}

fileprivate enum UserDefaultKey: String {
    case token = "token"
}

final class APIManager: APIManagerProtocol {
    
    var token: String? {
        get {
            UserDefaults.standard.string(forKey: UserDefaultKey.token.rawValue)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: UserDefaultKey.token.rawValue)
        }
    }
    
    private let urlSession: URLSession
    private let jsonDecoder: JSONDecoder
    
    init(urlSession: URLSession = .shared, jsonDecoder: JSONDecoder = .init()) {
        self.urlSession = urlSession
        self.jsonDecoder = jsonDecoder
    }
    
    func getSpotifyContent<T: Decodable>(type: T.Type, endpoint: APIEndpoint) async throws -> T {
        guard let url = endpoint.url else { throw APIError.badURl }
        
        let request = endpoint.getRequest(url: url)
        
        guard let (data, resp) = try? await urlSession.data(for: request) else { print(APIError.cannotGet); throw APIError.cannotGet }
        
        if let httpResponse = resp as? HTTPURLResponse {
            print(httpResponse.statusCode)
        }
        
        guard let result = try? jsonDecoder.decode(T.self, from: data) else { print(APIError.cannotDecode); throw APIError.cannotDecode}
        
        if result is OauthCode {
            token = (result as! OauthCode).access_token
        }
        
        return result
    }
    
}

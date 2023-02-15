//
//  EndpointProtocol.swift
//  SpotifyClone
//
//  Created by Павел Кай on 14.02.2023.
//

import Foundation

protocol Endpoint {
    var httpMethod: String { get }
    func urlComponents(scheme: String, host: String, path: String, queryItems: [URLQueryItem]?) -> URL?
    var url: URL? { get }
    func getRequest(url: URL) -> URLRequest
}

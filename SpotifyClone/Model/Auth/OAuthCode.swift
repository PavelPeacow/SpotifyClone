//
//  OAuthCode.swift
//  SpotifyClone
//
//  Created by Павел Кай on 19.01.2023.
//

struct OauthToken: Decodable {
    let accessToken: String
    let refreshToken: String?
    let expiresIn: Int
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
        case expiresIn = "expires_in"
    }
}

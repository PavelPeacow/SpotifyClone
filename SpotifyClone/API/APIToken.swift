//
//  APIToken.swift
//  SpotifyClone
//
//  Created by Павел Кай on 31.01.2023.
//

import Foundation

final class Token {
    
    private init() { }
    
    enum UserDefaultKey: String {
        case isSignedIn = "isSignedIn"
        case token = "token"
        case refreshToken = "resfreshToken"
        case expirationDate = "expirationDate"
        case isUsedRefreshToken = "isUsedRefreshToken"
    }
    
    static let shared = Token()
    
    var isSignedIn: Bool {
        get {
            UserDefaults.standard.bool(forKey: UserDefaultKey.isSignedIn.rawValue)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: UserDefaultKey.isSignedIn.rawValue)
        }
    }
    
    var isUsedRefreshToken: Bool {
        get {
            UserDefaults.standard.bool(forKey: UserDefaultKey.isUsedRefreshToken.rawValue)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: UserDefaultKey.isUsedRefreshToken.rawValue)
        }
    }
    
    var token: String? {
        get {
            UserDefaults.standard.string(forKey: UserDefaultKey.token.rawValue)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: UserDefaultKey.token.rawValue)
        }
    }
    
    var refreshToken: String? {
        get {
            UserDefaults.standard.string(forKey: UserDefaultKey.refreshToken.rawValue)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: UserDefaultKey.refreshToken.rawValue)
        }
    }
    
    var expirationDate: Date? {
        get {
            UserDefaults.standard.object(forKey: UserDefaultKey.expirationDate.rawValue) as? Date
        }
        set {
            
            UserDefaults.standard.set(newValue, forKey: UserDefaultKey.expirationDate.rawValue)
        }
    }
    
    func cacheToken(with model: OauthToken?) {
        guard let model = model else { return }
        token = model.accessToken
        refreshToken = model.refreshToken
        isUsedRefreshToken = false
        isSignedIn = true
        
        let timeInterval = TimeInterval(model.expiresIn)
        let expirationDate = Date().addingTimeInterval(timeInterval)
        self.expirationDate = expirationDate
    }
    
    func shouldRefreshToken() -> Bool {
        guard let expirationDate = expirationDate else { return false }
        let currentDate = Date()
        let fiveMinutes: TimeInterval = 300
        
        return currentDate.addingTimeInterval(fiveMinutes) >= expirationDate
    }
    
    func getRefreshToken() {
        guard isSignedIn else { return }
        guard let refreshToken = refreshToken else { return }
        guard shouldRefreshToken() else { return }
        
        Task {
            do {
                let result = try await APIManager().getSpotifyContent(type: OauthToken.self, endpoint: AuthEndpoint.getRefreshToken(token: refreshToken))
                token = result.accessToken
                isUsedRefreshToken = true
                let timeInterval = TimeInterval(result.expiresIn)
                let expirationDate = Date().addingTimeInterval(timeInterval)
                self.expirationDate = expirationDate
            } catch {
                print(error)
            }
            isSignedIn = false
        }
        
    }
}

//
//  LoginViewModel.swift
//  SpotifyClone
//
//  Created by Павел Кай on 19.01.2023.
//

import AuthenticationServices
import UIKit

enum AouthError: Error {
    case errorSignIn
}

final class LoginViewModel {
    
    func showOAuthPrompt(in view: UIViewController, then onCompletion: @escaping (Result<Void, AouthError>) -> ()) {

        guard let url = AuthEndpoint.getCode.url else { return }
        let callBackScheme = APIConstant.callbackScheme
        
        let session = ASWebAuthenticationSession(url: url, callbackURLScheme: callBackScheme) { callbackURL, error in
            guard let callbackURL = callbackURL, error == nil else { return }
            guard let query = URLComponents(string: callbackURL.absoluteString)?.queryItems else { return }
            
            Task {
                if let code = query.first(where: {$0.name == "code" })?.value {
                    let result = try? await APIManager().getSpotifyContent(type: OauthToken.self, endpoint: AuthEndpoint.exchangeCodeForToken(code: code))
                    Token.shared.cacheToken(with: result)
                    Token.shared.isSignedIn = true
                    onCompletion(.success(()))
                } else {
                    onCompletion(.failure(.errorSignIn))
                }
                
            }
            
        }
        session.presentationContextProvider = view as? any ASWebAuthenticationPresentationContextProviding
        session.start()
    }
    
}

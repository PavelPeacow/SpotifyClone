//
//  LoginViewModel.swift
//  SpotifyClone
//
//  Created by Павел Кай on 19.01.2023.
//

import AuthenticationServices
import UIKit

final class LoginViewModel {
    
    func showOAuthPrompt(in view: UIViewController, then onCompletion: @escaping () -> ()) {

        guard let url = AuthEndpoint.getCode.url else { return }
        let callBackScheme = APIConstant.callbackScheme
        
        let session = ASWebAuthenticationSession(url: url, callbackURLScheme: callBackScheme) { callbackURL, error in
            guard let callbackURL = callbackURL, error == nil else { return }
            guard let query = URLComponents(string: callbackURL.absoluteString)?.queryItems else { return }
            
            Task {
                if let code = query.first(where: {$0.name == "code" })?.value {
                    _ = try? await APIManager().getSpotifyContent(type: OauthCode.self, endpoint: AuthEndpoint.exchangeCodeForToken(code: code))
                    onCompletion()
                }
            }
            
        }
        session.presentationContextProvider = view as? any ASWebAuthenticationPresentationContextProviding
        session.start()
    }
    
}

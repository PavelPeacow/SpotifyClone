//
//  SceneDelegate.swift
//  SpotifyClone
//
//  Created by Павел Кай on 19.01.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    var timer: Timer?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(checkForToken), userInfo: nil, repeats: true)

        if Token.shared.isSignedIn {
            window.rootViewController = MainTabBarViewController()
        } else {
            let nav = UINavigationController(rootViewController: LoginViewController())
            window.rootViewController = nav
        }
        
        window.makeKeyAndVisible()
        self.window = window
    }

}

extension SceneDelegate {
    
    @objc func checkForToken() {
        if Token.shared.shouldRefreshToken() && !Token.shared.isUsedRefreshToken {
            Token.shared.getRefreshToken()
        } else if Token.shared.shouldRefreshToken() && Token.shared.isUsedRefreshToken {
            let ac = UIAlertController(title: "Token expired", message: "get new token!", preferredStyle: .alert)
            
            let vc = LoginViewController()
            vc.modalPresentationStyle = .fullScreen
            
            ac.addAction(UIAlertAction(title: "Get new token", style: .default, handler: { [weak self] _ in
                self?.window?.rootViewController?.present(vc, animated: true)
            }))
            
            window?.rootViewController?.present(ac, animated: true)
        }
    }
    
}

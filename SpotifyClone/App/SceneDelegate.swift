//
//  SceneDelegate.swift
//  SpotifyClone
//
//  Created by Павел Кай on 19.01.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        
        if false {
            window.rootViewController = MainTabBarViewController()
        } else {
            let nav = UINavigationController(rootViewController: LoginViewController())
            window.rootViewController = nav
        }
        
        window.makeKeyAndVisible()
        self.window = window
    }

}


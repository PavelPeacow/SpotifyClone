//
//  MainTabBarViewController.swift
//  SpotifyClone
//
//  Created by Павел Кай on 31.01.2023.
//

import UIKit

final class MainTabBarViewController: UITabBarController {
    
    let playerViewBottom = PlayerViewBottom()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(playerViewBottom)
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapPlayerView))
        playerViewBottom.addGestureRecognizer(gesture)
        
        setTabBar()
        setConstraints()
    }
    
    func setTabBar() {
        let home = UINavigationController(rootViewController: HomeViewController())
        
        home.navigationBar.tintColor = .white
        home.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem()
        
        home.tabBarItem.image = UIImage(systemName: "house.fill")
        home.tabBarItem.title = "Browse"
        
        setViewControllers([home], animated: true)
    }
}

extension MainTabBarViewController {
    
    @objc func didTapPlayerView() {
        present(PlayerViewController.shared, animated: true)
    }
    
}

extension MainTabBarViewController {
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            playerViewBottom.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            playerViewBottom.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            playerViewBottom.bottomAnchor.constraint(equalTo: tabBar.topAnchor),
            playerViewBottom.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
}

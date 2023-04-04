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
        view.tintColor = .white
        
        let home = UINavigationController(rootViewController: HomeViewController())
        
        home.navigationBar.tintColor = .white
        home.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem()
        
        home.tabBarItem.image = UIImage(systemName: "house.fill")
        home.tabBarItem.title = "Browse"
        
        let library = UINavigationController(rootViewController: LibraryViewController())
        
        library.navigationBar.tintColor = .white
        library.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem()
        
        library.tabBarItem.image = UIImage(systemName: "music.note.list")
        library.tabBarItem.title = "Your Library"
        
        let category = UINavigationController(rootViewController: CategoryViewController())
        
        category.navigationBar.tintColor = .white
        category.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem()
        
        category.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        category.tabBarItem.title = "Search"
        
        setViewControllers([home, library, category], animated: true)
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

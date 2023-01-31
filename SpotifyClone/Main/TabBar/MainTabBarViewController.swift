//
//  MainTabBarViewController.swift
//  SpotifyClone
//
//  Created by Павел Кай on 31.01.2023.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setTabBar()
    }
    
    func setTabBar() {
        let home = UINavigationController(rootViewController: HomeViewController())
        
        home.tabBarItem.image = UIImage(systemName: "house.fill")
        home.tabBarItem.title = "Browse"
        
        setViewControllers([home], animated: true)
    }

}

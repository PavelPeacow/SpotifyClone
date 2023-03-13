//
//  NavBar+Styling.swift
//  SpotifyClone
//
//  Created by Павел Кай on 13.03.2023.
//

import UIKit

extension UINavigationItem {
    
    func styleNavBar(color: UIColor, alpha: CGFloat) {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = color.withAlphaComponent(alpha)
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white.withAlphaComponent(alpha), .font: UIFont.setFont(.book, size: 16)]
        standardAppearance = appearance
        scrollEdgeAppearance = appearance
        compactAppearance = appearance
    }
    
}

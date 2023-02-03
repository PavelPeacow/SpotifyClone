//
//  UIButton+SFSymbol.swift
//  SpotifyClone
//
//  Created by Павел Кай on 03.02.2023.
//

import UIKit

extension UIButton {
    
    func setSFImage(systemName: String, size: CGFloat, color: UIColor) {
        let config = UIImage.SymbolConfiguration(pointSize: size, weight: .bold)
        let image = UIImage(systemName: systemName)?.withConfiguration(config).withTintColor(color, renderingMode: .alwaysOriginal)
        setImage(image, for: .normal)
    }
    
}

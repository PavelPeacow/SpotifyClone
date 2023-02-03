//
//  UIView+Shadows.swift
//  SpotifyClone
//
//  Created by Павел Кай on 03.02.2023.
//

import UIKit

extension UIView {
    
    func setShadows(shadowRadius: CGFloat = 25, shadowOffset: CGSize = .init(width: 0, height: 10)) {
        layer.shadowRadius = shadowRadius
        layer.shadowOffset = shadowOffset
        layer.shadowOpacity = 1
    }
    
}

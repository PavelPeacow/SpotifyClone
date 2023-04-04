//
//  UIView+BottomShadow.swift
//  SpotifyClone
//
//  Created by Павел Кай on 04.04.2023.
//

import UIKit

extension UIView {
    
    func addBottomShadow() {
        layer.masksToBounds = false
        layer.shadowRadius = 5
        layer.shadowOpacity = 1
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0 , height: 5)
    }
    
}

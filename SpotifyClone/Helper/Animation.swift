//
//  Animation.swift
//  SpotifyClone
//
//  Created by Павел Кай on 19.01.2023.
//

import UIKit

extension UIView {
    
    func animateTap(scale: CGFloat) {
        self.transform = CGAffineTransform(scaleX: scale, y: scale)
        
        UIView.animate(withDuration: 0.25) {
            self.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }
    }
    
}

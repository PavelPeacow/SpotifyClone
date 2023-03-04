//
//  Font.swift
//  SpotifyClone
//
//  Created by Павел Кай on 04.03.2023.
//

import UIKit

enum Fonts: String {
    case black = "CircularStd-Black"
    case bold = "CircularStd-Bold"
    case book = "CircularStd-Book"
    case light = "CircularSpotifyText-Light"
    case medium = "CircularStd-Medium"
}

extension UIFont {
    
    static func setFont(_ font: Fonts, size: CGFloat) -> UIFont {
        UIFont(name: font.rawValue, size: size)!
    }
    
}

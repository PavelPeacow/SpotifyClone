//
//  FloatingCover.swift
//  SpotifyClone
//
//  Created by Павел Кай on 02.02.2023.
//

import UIKit

class FloatingCover: UIView {

    private var coverHeight: NSLayoutConstraint?
    private var coverWidth: NSLayoutConstraint?
    
    private var heightConstant: CGFloat = 250
    private var widthConstant: CGFloat = 250
    
    private lazy var cover: UIImageViewURL = {
        let image = UIImageViewURL()
        image.contentMode = .scaleToFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(cover)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCover(with imageURL: String) {
        guard let url = URL(string: imageURL) else { return }
        cover.loadImage(for: url)
    }
    
}

extension FloatingCover {
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let y = scrollView.contentOffset.y
        
        guard let widthConstraint = coverWidth,
              let heightConstraint = coverHeight else { return }
        
        let normalizedScroll = y / 2
        
        widthConstraint.constant = heightConstant - normalizedScroll
        heightConstraint.constant = widthConstant - normalizedScroll
        
        let normalizedAlpha = y / 200
        alpha = 1.0 - normalizedAlpha
    }
    
}

extension FloatingCover {
    
    func setConstraints() {
        coverHeight = cover.heightAnchor.constraint(equalToConstant: heightConstant)
        coverWidth = cover.widthAnchor.constraint(equalToConstant: widthConstant)
        
        NSLayoutConstraint.activate([
            cover.topAnchor.constraint(equalTo: topAnchor),
            cover.centerXAnchor.constraint(equalTo: centerXAnchor),
            coverHeight!,
            coverWidth!,
        ])
    }
}


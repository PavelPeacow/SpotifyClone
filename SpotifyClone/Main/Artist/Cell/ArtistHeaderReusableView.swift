//
//  ArtistHeaderReusableView.swift
//  SpotifyClone
//
//  Created by Павел Кай on 14.02.2023.
//

import UIKit

final class ArtistHeaderReusableView: UICollectionReusableView {
    
    static let identifier = "ArtistHeaderReusableView"
    
    private var imageViewHeight = NSLayoutConstraint()
    private var imageViewBottom = NSLayoutConstraint()
    private var containerViewHeight = NSLayoutConstraint()

    lazy var imageView: UIImageViewURL = {
        let image = UIImageViewURL()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var artistTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        label.font = .systemFont(ofSize: 40, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(containerView)
        containerView.addSubview(imageView)
        
        addSubview(artistTitle)
        
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with title: String, imageURL: String) {
        guard let url = URL(string: imageURL) else { return }
        imageView.loadImage(for: url)
        artistTitle.text = title
    }
    
}

extension ArtistHeaderReusableView {
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let offsetY = -(scrollView.contentOffset.y + scrollView.contentInset.top)
        
        containerViewHeight.constant = scrollView.contentInset.top
        containerView.clipsToBounds = offsetY <= 0
        
        imageViewBottom.constant = offsetY >= 0 ? 0 : -offsetY / 2
        imageViewHeight.constant = max(offsetY + scrollView.contentInset.top, scrollView.contentInset.top)
        
        alpha = 1.0 + offsetY / 200
        artistTitle.alpha = 1.0 - offsetY / 100
    }
    
}

extension ArtistHeaderReusableView {
    
    func setConstraints() {
        containerViewHeight = containerView.heightAnchor.constraint(equalTo: heightAnchor)
        
        imageViewBottom = imageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        imageViewHeight = imageView.heightAnchor.constraint(equalTo: containerView.heightAnchor)
        
        NSLayoutConstraint.activate([
            containerView.widthAnchor.constraint(equalTo: imageView.widthAnchor),
            
            artistTitle.bottomAnchor.constraint(equalTo: bottomAnchor),
            artistTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            artistTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            
            widthAnchor.constraint(equalTo: containerView.widthAnchor),
            centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            heightAnchor.constraint(equalTo: containerView.heightAnchor),
            
            containerViewHeight,
            imageViewBottom,
            imageViewHeight,
        ])
    }
    
}

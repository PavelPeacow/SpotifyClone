//
//  ArtistTopTracksCollectionViewCell.swift
//  SpotifyClone
//
//  Created by Павел Кай on 14.02.2023.
//

import UIKit

class ArtistTopTracksCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ArtistTopTracksCollectionViewCell"
    
    lazy var albumImage: UIImageViewURL = {
        let image = UIImageViewURL()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy var trackTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(albumImage)
        contentView.addSubview(trackTitle)
        
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with title: String, imageURL: String) {
        guard let url = URL(string: imageURL) else { return }
        albumImage.loadImage(for: url)
        trackTitle.text = title
    }
}

extension ArtistTopTracksCollectionViewCell {
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            albumImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            albumImage.heightAnchor.constraint(equalToConstant: 50),
            albumImage.widthAnchor.constraint(equalToConstant: 50),
            albumImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            trackTitle.leadingAnchor.constraint(equalTo: albumImage.trailingAnchor, constant: 5),
            trackTitle.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])
    }
    
}

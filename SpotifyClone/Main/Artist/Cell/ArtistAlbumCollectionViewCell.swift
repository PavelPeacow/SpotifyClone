//
//  ArtistAlbumCollectionViewCell.swift
//  SpotifyClone
//
//  Created by Павел Кай on 03.03.2023.
//

import UIKit

class ArtistAlbumCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ArtistAlbumCollectionViewCell"
    
    lazy var albumCover: UIImageViewURL = {
        let image = UIImageViewURL()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .red
        return image
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [albumTitle, albumInformation])
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var albumTitle: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
    
    lazy var albumInformation: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.addSubview(albumCover)
        contentView.addSubview(stackView)
        
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(albumCover: String, albumTitle: String, type: String, date: String) {
        guard let url = URL(string: albumCover) else { return }
        self.albumCover.loadImage(for: url)
        self.albumTitle.text = albumTitle
        self.albumInformation.text = "\(date.prefix(4)) ● \(type.capitalized)"
    }
    
}

extension ArtistAlbumCollectionViewCell {
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            albumCover.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            albumCover.topAnchor.constraint(equalTo: contentView.topAnchor),
            albumCover.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            albumCover.widthAnchor.constraint(equalToConstant: 100),
            
            stackView.leadingAnchor.constraint(equalTo: albumCover.trailingAnchor, constant: 5),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])
    }
    
}

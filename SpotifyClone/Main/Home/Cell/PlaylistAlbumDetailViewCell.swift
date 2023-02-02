//
//  PlaylistAlbumDetailViewCell.swift
//  SpotifyClone
//
//  Created by Павел Кай on 28.01.2023.
//

import UIKit

final class PlaylistAlbumDetailViewCell: UICollectionViewCell {
    
    static let identifier = "AlbumCollectionViewCell"
    
    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [trackImage, titlesStackView])
        stackView.spacing = 8
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var titlesStackView: UIStackView = {
       let stackView = UIStackView(arrangedSubviews: [trackTitle, groupTitle])
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.alignment = .fill
        return stackView
    }()
    
    private lazy var trackImage: UIImageViewURL = {
        let image = UIImageViewURL()
        image.contentMode = .scaleAspectFit
        image.isHidden = true
        return image
    }()
    
    private lazy var trackTitle: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var groupTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .thin)
        label.textColor = .gray
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(contentStackView)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(imageURL: String? = nil, trackTitle: String, groupTitle: String) {
        if let imageURL = imageURL {
            guard let url = URL(string: imageURL) else { return }
            trackImage.isHidden = false
            trackImage.loadImage(for: url)
        }

        self.trackTitle.text = trackTitle
        self.groupTitle.text = groupTitle
    }
    
}

extension PlaylistAlbumDetailViewCell {
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            trackImage.heightAnchor.constraint(equalToConstant: 50),
            trackImage.widthAnchor.constraint(equalToConstant: 50),
            
            contentStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            contentStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
        ])
    }
    
}

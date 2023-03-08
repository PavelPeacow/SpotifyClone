//
//  PlaylistAlbumFooterCollectionReusableView.swift
//  SpotifyClone
//
//  Created by Павел Кай on 08.03.2023.
//

import UIKit

class PlaylistAlbumFooterCollectionReusableView: UICollectionReusableView {
        
    static let identifier = "PlaylistAlbumFooterCollectionReusableView"
    
    lazy var stackViewContent: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [stackViewDescription])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        stackView.spacing = 10
        stackView.alignment = .fill
        stackView.axis = .vertical
        return stackView
    }()
    
    lazy var stackViewDescription: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [date, songsCountAndTime])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        stackView.spacing = 10
        stackView.alignment = .fill
        stackView.axis = .vertical
        return stackView
    }()
    
    lazy var date: UILabel = {
        let label = UILabel()
        label.font = .setFont(.book, size: 15)
        return label
    }()
    
    lazy var songsCountAndTime: UILabel = {
        let label = UILabel()
        label.font = .setFont(.book, size: 15)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(stackViewContent)
        
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(date: String, trackCount: Int, playingTime: String, artists: [Artist]) {
        self.date.text = date
        songsCountAndTime.text = "\(trackCount), \(playingTime)"
        print(artists)
        
        artists.forEach { artist in
            guard let url = URL(string: artist.images?.first?.url ?? "") else { return }
            
            let image = UIImageViewURL()
            image.contentMode = .scaleAspectFit
            image.loadImage(for: url)
            image.clipsToBounds = true
            image.layer.cornerRadius = 25
            
            NSLayoutConstraint.activate([
                image.heightAnchor.constraint(equalToConstant: 50),
                image.widthAnchor.constraint(equalToConstant: 50),
            ])
            
            let label = UILabel()
            label.font = .setFont(.book, size: 16)
            label.text = artist.name ?? ""
            
            let stackView = UIStackView(arrangedSubviews: [image, label])
            stackView.spacing = 8
            stackView.distribution = .fill
            stackView.alignment = .fill
            stackView.axis = .horizontal
            
            stackViewContent.addArrangedSubview(stackView)
        }
    }
    
}

extension PlaylistAlbumFooterCollectionReusableView {
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            stackViewContent.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            stackViewContent.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            stackViewContent.topAnchor.constraint(equalTo: topAnchor, constant: 25),
        ])
    }
    
}

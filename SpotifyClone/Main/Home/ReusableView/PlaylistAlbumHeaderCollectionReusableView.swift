//
//  PlaylistAlbumHeaderCollectionReusableView.swift
//  SpotifyClone
//
//  Created by Павел Кай on 31.01.2023.
//

import UIKit

protocol PlaylistAlbumHeaderCollectionReusableViewDelegate {
    func didTapArtist()
}

class PlaylistAlbumHeaderCollectionReusableView: UICollectionReusableView {
    
    static let identifier = "PlaylistAlbumHeaderCollectionReusableView"
    
    var delegate: PlaylistAlbumHeaderCollectionReusableViewDelegate?
    
    private lazy var stackViewDescription: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [title, stackViewArtist, typeAndDate])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        stackView.spacing = 10
        stackView.alignment = .fill
        stackView.axis = .vertical
        return stackView
    }()
    
    private lazy var title: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 2
        label.isUserInteractionEnabled = true
        return label
    }()
    
    private lazy var stackViewArtist: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [artistImage, artistTitle])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        stackView.spacing = 10
        stackView.alignment = .fill
        stackView.axis = .horizontal
        stackView.isUserInteractionEnabled = true
        return stackView
    }()
    
    private lazy var artistImage: UIImageViewURL = {
        let image = UIImageViewURL()
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        return image
    }()
    
    private lazy var artistTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var typeAndDate: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .gray
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(stackViewDescription)
        addGestures()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addGestures() {
        let tapArtist = UITapGestureRecognizer(target: self, action: #selector(didTapArtist))
        stackViewArtist.addGestureRecognizer(tapArtist)
    }
    
    func setCover(title: String, typeAndDate: String?, artistImage: String, artistTitle: String) {
        self.title.text = title
        self.typeAndDate.text = typeAndDate
        self.artistTitle.text = artistTitle
        print(artistImage)
        
        guard let url = URL(string: artistImage) else { return }
        
        self.artistImage.loadImage(for: url)
        layoutIfNeeded()
        self.artistImage.layer.cornerRadius = self.artistImage.frame.height / 2
    }
    
}

extension PlaylistAlbumHeaderCollectionReusableView {
    
    @objc func didTapArtist() {
        delegate?.didTapArtist()
    }

}

extension PlaylistAlbumHeaderCollectionReusableView {
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            stackViewDescription.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
            stackViewDescription.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            stackViewDescription.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            
            artistImage.heightAnchor.constraint(equalToConstant: 40),
            artistImage.widthAnchor.constraint(equalToConstant: 40),
        ])
    }
}

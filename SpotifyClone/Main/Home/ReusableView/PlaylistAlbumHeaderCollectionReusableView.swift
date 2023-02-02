//
//  PlaylistAlbumHeaderCollectionReusableView.swift
//  SpotifyClone
//
//  Created by Павел Кай on 31.01.2023.
//

import UIKit

class PlaylistAlbumHeaderCollectionReusableView: UICollectionReusableView {
    
    static let identifier = "PlaylistAlbumHeaderCollectionReusableView"
    
    private lazy var stackViewDescription: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [title, typeAndDate])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        stackView.spacing = 3
        stackView.alignment = .fill
        stackView.axis = .vertical
        return stackView
    }()
    
    private lazy var title: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var typeAndDate: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .gray
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(stackViewDescription)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCover(title: String, typeAndDate: String) {
        self.title.text = title
        self.typeAndDate.text = typeAndDate
    }
    
}

extension PlaylistAlbumHeaderCollectionReusableView {
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            stackViewDescription.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            stackViewDescription.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            stackViewDescription.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
        ])
    }
}

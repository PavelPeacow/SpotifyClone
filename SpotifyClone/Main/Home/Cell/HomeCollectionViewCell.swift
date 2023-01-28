//
//  HomeCollectionViewCell.swift
//  SpotifyClone
//
//  Created by Павел Кай on 27.01.2023.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "HomeCollectionViewCell"
    
    private lazy var image: UIImageViewURL = {
        let image = UIImageViewURL()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var title: UILabel = {
        let label = UILabel()
        label.text = "Lool"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .blue
        contentView.addSubview(image)
        contentView.addSubview(title)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with title: String, imageURL: String) {
        guard let url = URL(string: imageURL) else { return }
        self.title.text = title
        image.loadImage(for: url)
    }
    
}

extension HomeCollectionViewCell {
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: contentView.topAnchor),
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            image.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            image.bottomAnchor.constraint(equalTo: title.topAnchor, constant: -5),
            
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            title.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
}

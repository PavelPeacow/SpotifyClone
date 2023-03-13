//
//  SearchCollectionViewCell.swift
//  SpotifyClone
//
//  Created by Павел Кай on 12.03.2023.
//

import UIKit

class SearchCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "SearchCollectionViewCell"
    
    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [searchItemImage, titlesStackView])
        stackView.spacing = 8
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var titlesStackView: UIStackView = {
       let stackView = UIStackView(arrangedSubviews: [searchItemTitle, searchItemSubtitle])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        return stackView
    }()
    
    private lazy var searchItemImage: UIImageViewURL = {
        let image = UIImageViewURL()
        image.contentMode = .scaleAspectFit
        return image
    }()
    
     lazy var searchItemTitle: UILabel = {
        let label = UILabel()
        label.font = .setFont(.book, size: 16)
        return label
    }()
    
    private lazy var searchItemSubtitle: UILabel = {
        let label = UILabel()
        label.font = .setFont(.book, size: 16)
        label.textColor = .secondaryLabel
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(contentStackView)
        
        setConstraints()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        searchItemImage.layer.cornerRadius = 0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(image: String, searchItemTitle: String, searchItemSubtitle: String, isArtistItem: Bool = false) {
        guard let url = URL(string: image) else { return }
        searchItemImage.loadImage(for: url)
        
        if isArtistItem {
            searchItemImage.layer.cornerRadius = 30
            searchItemImage.clipsToBounds = true
        }
        
        self.searchItemTitle.text = searchItemTitle
        self.searchItemSubtitle.text = searchItemSubtitle
    }
    
}

extension SearchCollectionViewCell {
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            searchItemImage.heightAnchor.constraint(equalToConstant: 60),
            searchItemImage.widthAnchor.constraint(equalToConstant: 60),
            
            contentStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            contentStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
    
}

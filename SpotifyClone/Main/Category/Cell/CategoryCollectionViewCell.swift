//
//  CategoryCollectionViewCell.swift
//  SpotifyClone
//
//  Created by Павел Кай on 10.03.2023.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CategoryCollectionViewCell"
    
    lazy var categoryTitle: UILabel = {
        let label = UILabel()
        label.font = .setFont(.bold, size: 18)
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var roundedContainer: UIView = {
        let view = UIView()
        view.setShadows(shadowRadius: 15, shadowOffset: .init(width: 0, height: 0))
        view.transform = .init(rotationAngle: .pi / 8)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var categoryImage: UIImageViewURL = {
        let image = UIImageViewURL()
        image.contentMode = .scaleAspectFit
        image.layer.cornerRadius = 5
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.layer.cornerRadius = 5
        contentView.clipsToBounds = true
        
        contentView.addSubview(categoryTitle)
        
        roundedContainer.addSubview(categoryImage)
        contentView.addSubview(roundedContainer)
        
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(title: String, image: String) {
        guard let url = URL(string: image) else { print(title); return }
        
        categoryTitle.text = title
        categoryImage.loadImage(for: url) { [weak self] in
            UIView.animate(withDuration: 0.25) {
                self?.contentView.backgroundColor = self?.categoryImage.image?.averageColor ?? .green
            }
        }
    }
    
}

extension CategoryCollectionViewCell {
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            categoryTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            categoryTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            categoryTitle.trailingAnchor.constraint(equalTo: categoryImage.leadingAnchor, constant: 5),
            
            roundedContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 20),
            roundedContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 10),
            roundedContainer.heightAnchor.constraint(equalToConstant: 90),
            roundedContainer.widthAnchor.constraint(equalToConstant: 90),
            
            categoryImage.trailingAnchor.constraint(equalTo: roundedContainer.trailingAnchor),
            categoryImage.bottomAnchor.constraint(equalTo: roundedContainer.bottomAnchor),
            categoryImage.heightAnchor.constraint(equalTo: roundedContainer.heightAnchor),
            categoryImage.widthAnchor.constraint(equalTo: roundedContainer.widthAnchor),
        ])
    }
    
}

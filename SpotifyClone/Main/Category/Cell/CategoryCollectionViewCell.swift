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
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var categoryImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .orange
        contentView.layer.cornerRadius = 5
        contentView.clipsToBounds = true
        
        contentView.addSubview(categoryTitle)
        contentView.addSubview(categoryImage)
        
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(title: String, image: String) {
        categoryTitle.text = title
        categoryImage.image = UIImage(systemName: "house")
        categoryImage.transform = .init(rotationAngle: 45)
    }
    
}

extension CategoryCollectionViewCell {
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            categoryTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            categoryTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            categoryTitle.trailingAnchor.constraint(equalTo: categoryImage.leadingAnchor, constant: 5),
            
            categoryImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            categoryImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            
        ])
    }
    
}

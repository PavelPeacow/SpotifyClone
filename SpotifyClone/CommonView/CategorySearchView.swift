//
//  CategorySearchView.swift
//  SpotifyClone
//
//  Created by Павел Кай on 10.03.2023.
//

import UIKit

class CategorySearchView: UIView {
    
    lazy var stackViewContent: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [searchIcon, searchText])
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.axis = .horizontal
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var searchIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "magnifyingglass")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        return image
    }()
    
    lazy var searchText: UILabel = {
        let label = UILabel()
        label.text = "What do you want to listen to?"
        label.textColor = .black
        label.font = .setFont(.book, size: 16)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        layer.cornerRadius = 5
        
        addSubview(stackViewContent)
        
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension CategorySearchView {
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            stackViewContent.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackViewContent.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            stackViewContent.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            
            searchIcon.heightAnchor.constraint(equalToConstant: 30),
            searchIcon.widthAnchor.constraint(equalToConstant: 30),
        ])
    }
    
}

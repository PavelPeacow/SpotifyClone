//
//  CategoryLibraryView.swift
//  SpotifyClone
//
//  Created by Павел Кай on 04.04.2023.
//

import UIKit

class CategoryLibraryView: UIView {
    
    var isSelected = false {
        willSet {
            if newValue == true {
                backgroundColor = .systemGreen
                categoryTitle.textColor = .black
            } else {
                backgroundColor = .systemGray6
                categoryTitle.textColor = .white
            }
        }
    }
    
    lazy var categoryTitle: UILabel = {
        let label = UILabel()
        label.font = .setFont(.light, size: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(categoryTitle)
        
        backgroundColor = .systemGray6
        layer.cornerRadius = 16
        
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(title: String) {
        categoryTitle.text = title
    }

}

extension CategoryLibraryView {
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            categoryTitle.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            categoryTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            categoryTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            categoryTitle.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
        ])
    }
    
}

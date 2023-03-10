//
//  CategoryHeaderCollectionReusableView.swift
//  SpotifyClone
//
//  Created by Павел Кай on 10.03.2023.
//

import UIKit

protocol CategoryHeaderCollectionReusableViewDelegate {
    func didTapSearchView()
}

class CategoryHeaderCollectionReusableView: UICollectionReusableView {
    
    static let identifier = "CategoryHeaderCollectionReusableView"
    
    var delegate: CategoryHeaderCollectionReusableViewDelegate?
    
    lazy var categorySearchTitle: UILabel = {
        let label = UILabel()
        label.text = "Search"
        label.font = .setFont(.bold, size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var categorySearchView: CategorySearchView = {
        let view = CategorySearchView()
        view.translatesAutoresizingMaskIntoConstraints = false
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapSearchView))
        view.addGestureRecognizer(gesture)
        return view
    }()
    
    lazy var categorySubtitle: UILabel = {
        let label = UILabel()
        label.font = .setFont(.bold, size: 16)
        label.text = "Browse all"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(categorySearchTitle)
        addSubview(categorySearchView)
        addSubview(categorySubtitle)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension CategoryHeaderCollectionReusableView {
    
    @objc func didTapSearchView() {
        delegate?.didTapSearchView()
    }
    
}

extension CategoryHeaderCollectionReusableView {
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            categorySearchTitle.topAnchor.constraint(equalTo: topAnchor),
            categorySearchTitle.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            categorySearchView.topAnchor.constraint(equalTo: categorySearchTitle.bottomAnchor, constant: 5),
            categorySearchView.leadingAnchor.constraint(equalTo: leadingAnchor),
            categorySearchView.trailingAnchor.constraint(equalTo: trailingAnchor),
            categorySearchView.heightAnchor.constraint(equalToConstant: 35),
            
            categorySubtitle.topAnchor.constraint(equalTo: categorySearchView.bottomAnchor, constant: 15),
            categorySubtitle.leadingAnchor.constraint(equalTo: leadingAnchor),
        ])
    }
    
}

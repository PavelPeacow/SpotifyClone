//
//  AlbumDetailView.swift
//  SpotifyClone
//
//  Created by Павел Кай on 28.01.2023.
//

import UIKit

final class PlaylistAlbumDetailView: UIView {
    
    lazy var floatingCover: FloatingCover = {
        let cover = FloatingCover()
        cover.translatesAutoresizingMaskIntoConstraints = false
        cover.isUserInteractionEnabled = false
        cover.layer.zPosition = -1
        return cover
    }()
    
    lazy var gradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.type = .axial
        gradient.zPosition = -2
        gradient.locations = [0, 1]
        return gradient
    }()
    
    lazy var container: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.zPosition = -3
        return view
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(PlaylistAlbumDetailViewCell.self, forCellWithReuseIdentifier: PlaylistAlbumDetailViewCell.identifier)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .mainBackground
        
        collection.register(PlaylistAlbumHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: PlaylistAlbumHeaderCollectionReusableView.identifier)
        return collection
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        addSubview(collectionView)
        collectionView.addSubview(floatingCover)
        collectionView.layer.addSublayer(gradient)
        
        floatingCover.addSubview(container)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PlaylistAlbumDetailView {
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            floatingCover.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            floatingCover.centerXAnchor.constraint(equalTo: centerXAnchor),
            floatingCover.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1),
            floatingCover.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.45),
            
            container.bottomAnchor.constraint(equalTo: collectionView.topAnchor),
            container.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1),
            container.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1),
        ])
    }
}

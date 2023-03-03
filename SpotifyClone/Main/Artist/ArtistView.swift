//
//  ArtistView.swift
//  SpotifyClone
//
//  Created by Павел Кай on 14.02.2023.
//

import UIKit

final class ArtistView: UIView {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewCompositionalLayout.createSectionsForArtist()
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(ArtistTopTracksCollectionViewCell.self, forCellWithReuseIdentifier: ArtistTopTracksCollectionViewCell.identifier)
        collectionView.register(ArtistAlbumCollectionViewCell.self, forCellWithReuseIdentifier: ArtistAlbumCollectionViewCell.identifier)
        collectionView.contentInsetAdjustmentBehavior = .never
        
        collectionView.register(HeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionReusableView.identifier)
        collectionView.register(ArtistHeaderReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ArtistHeaderReusableView.identifier)
        return collectionView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(collectionView)

        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension ArtistView {
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
}

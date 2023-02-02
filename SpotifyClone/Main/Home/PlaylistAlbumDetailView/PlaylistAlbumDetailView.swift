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
        cover.layer.zPosition = -1
        return cover
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(PlaylistAlbumDetailViewCell.self, forCellWithReuseIdentifier: PlaylistAlbumDetailViewCell.identifier)
        collection.translatesAutoresizingMaskIntoConstraints = false
        
        collection.register(PlaylistAlbumHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: PlaylistAlbumHeaderCollectionReusableView.identifier)
        return collection
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        addSubview(collectionView)
        collectionView.addSubview(floatingCover)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PlaylistAlbumDetailView {
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            floatingCover.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            floatingCover.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
}

//
//  CategoryPlaylistsViewController.swift
//  SpotifyClone
//
//  Created by Павел Кай on 13.03.2023.
//

import UIKit

class CategoryPlaylistsViewController: UIViewController {
    
    let viewModel = CategoryPlaylistsViewModel()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewCompositionalLayout { Int, env in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
            
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(200))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 3)
            group.interItemSpacing = .fixed(15)
            
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: 15, leading: 15, bottom: 15, trailing: 15)
            section.interGroupSpacing = 15
            
            return section
        }
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: HomeCollectionViewCell.identifier)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .mainBackground
        collection.delegate = self
        collection.dataSource = self
        return collection
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(collectionView)
        setConstraints()
    }
    
    func configure(playlists: [PlaylistItem]) {
        viewModel.categoryPlaylits = playlists
    }
    
}

extension CategoryPlaylistsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.categoryPlaylits.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identifier, for: indexPath) as! HomeCollectionViewCell
        
        let item = viewModel.categoryPlaylits[indexPath.row]
        
        cell.configure(with: item.name, imageURL: item.images.first?.url ?? "")
        
        return cell
    }
    
}

extension CategoryPlaylistsViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        Task {
            let playlist = viewModel.categoryPlaylits[indexPath.row]

            let id = playlist.id
            
            let tracks = await viewModel.getPlaylistContent(playlistID: id)
            let user = await viewModel.getUser(userID: playlist.owner.id)
            
            let tracksArray = tracks?.reduce(into: [Track](), { $0.append($1.track) })
            
            let vc = PlaylistAlbumDetailViewController()
            vc.configure(tracks: tracksArray, playlist: playlist, user: user)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}

extension CategoryPlaylistsViewController {
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
}

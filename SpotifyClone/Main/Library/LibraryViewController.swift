//
//  LibraryViewController.swift
//  SpotifyClone
//
//  Created by Павел Кай on 02.04.2023.
//

import UIKit

class LibraryViewController: UIViewController {
    
    let viewModel = LibraryViewModel()
    
    lazy var libraryTopView: LibraryTopView = {
        let view = LibraryTopView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewCompositionalLayout { sec, env in
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(60))
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = .init(top: 15, leading: 15, bottom: 15, trailing: 15)
            section.interGroupSpacing = 15
            
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(30))
            let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)

            section.boundarySupplementaryItems = [header]
            
            return section
        }
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: SearchCollectionViewCell.identifier)
        collectionView.register(LibraryFilterCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: LibraryFilterCollectionReusableView.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .mainBackground
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(libraryTopView)
        view.addSubview(collectionView)
        
        view.backgroundColor = .mainBackground
        
        Task {
            await viewModel.getCurrentUserAlbums()
            collectionView.reloadData()
        }
        
        setDelegates()
        setConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func setDelegates() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
}

extension LibraryViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.userAlbums.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCell.identifier, for: indexPath) as! SearchCollectionViewCell
        
        let albumItem = viewModel.userAlbums[indexPath.row]
        
        let image = albumItem.album.images?.first?.url ?? ""
        let title = albumItem.album.name ?? ""
        let subtitle = "\(albumItem.album.albumType?.capitalized ?? "") - \(albumItem.album.artists?.first?.name ?? "")"
        
        cell.configure(image: image, searchItemTitle: title, searchItemSubtitle: subtitle)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: LibraryFilterCollectionReusableView.identifier, for: indexPath) as! LibraryFilterCollectionReusableView
        
        return header
    }
    
}

extension LibraryViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}

extension LibraryViewController {
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            libraryTopView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            libraryTopView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            libraryTopView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            libraryTopView.heightAnchor.constraint(equalToConstant: 115),
            
            collectionView.topAnchor.constraint(equalTo: libraryTopView.bottomAnchor, constant: 0),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
}

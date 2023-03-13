//
//  SearchViewController.swift
//  SpotifyClone
//
//  Created by Павел Кай on 11.03.2023.
//

import UIKit

class SearchViewController: UIViewController {
    
    let viewModel = SearchViewModel()
    var searchTimer: Timer?
    
    lazy var searchContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var searchStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [searchTextField, cancelBtn])
        stackView.distribution = .fillProportionally
        stackView.alignment = .fill
        stackView.axis = .horizontal
        stackView.spacing = 15
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var searchTextField: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "What do you want to listen to?"
        textfield.translatesAutoresizingMaskIntoConstraints = false
        
        let container = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 30))
        let imageView = UIImageView(frame: CGRect(x: 5, y: 3, width: 25, height: 25))
        imageView.contentMode = .scaleAspectFit
        container.addSubview(imageView)
        
        imageView.image = UIImage(systemName: "magnifyingglass")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        textfield.leftView = container
        textfield.leftViewMode = .always
        textfield.layer.cornerRadius = 5
        textfield.backgroundColor = .systemGray5
        textfield.tintColor = .green
        textfield.autocorrectionType = .no
        textfield.autocapitalizationType = .none
        textfield.addTarget(self, action: #selector(didEnterSearchQuery), for: .editingChanged)
        
        return textfield
    }()
    
    lazy var cancelBtn: UIButton = {
        let btn =  UIButton()
        btn.setTitle("Cancel", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.addTarget(self, action: #selector(didTapCancelBtn), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewCompositionalLayout { Int, env in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
            
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(60))
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
            group.interItemSpacing = .fixed(15)
            
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: 15, leading: 15, bottom: 15, trailing: 15)
            section.interGroupSpacing = 15
            
            return section
        }
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: SearchCollectionViewCell.identifier)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .mainBackground
        collection.delegate = self
        collection.dataSource = self
        return collection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        view.addSubview(collectionView)
        view.backgroundColor = .mainBackground
        searchContainer.addSubview(searchStackView)
        
        view.addSubview(searchContainer)
        
        setConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
        searchTextField.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
}

extension SearchViewController {
    
    @objc func didTapCancelBtn() {
        navigationController?.popViewController(animated: false)
    }
    
    @objc func didEnterSearchQuery(_ sender: UITextField) {
        searchTimer?.invalidate()
        
        searchTimer = Timer.scheduledTimer(withTimeInterval: 0.25, repeats: false, block: { [weak self] _ in
            guard let query = sender.text, !query.isEmpty else {
                self?.viewModel.allResults = []
                self?.collectionView.reloadData()
                UIView.animate(withDuration: 0.25) {
                    self?.searchContainer.backgroundColor = .systemGray6
                }
                return
            }
            
            Task {
                await self?.viewModel.getSearchResults(query: query, type: "album,track,artist")
                self?.collectionView.reloadData()
                UIView.animate(withDuration: 0.25) {
                    self?.searchContainer.backgroundColor = self?.viewModel.color
                }
            }
        })
        
    }
    
}

extension SearchViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.allResults.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let value = viewModel.allResults[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCell.identifier, for: indexPath) as! SearchCollectionViewCell
        
        let searchImage: String
        let searchTitle: String
        let searchSubtitle: String
        
        if let artist = value as? Artist {
            searchImage = artist.images?.first?.url ?? ""
            searchTitle = artist.name ?? ""
            searchSubtitle = artist.type?.capitalized ?? ""
            cell.configure(image: searchImage, searchItemTitle: searchTitle, searchItemSubtitle: searchSubtitle, isArtistItem: true)
        } else if let album = value as? Album {
            searchImage = album.images?.first?.url ?? ""
            searchTitle = album.name ?? ""
            searchSubtitle = album.type?.capitalized ?? ""
            cell.configure(image: searchImage, searchItemTitle: searchTitle, searchItemSubtitle: searchSubtitle)
        } else if let track = value as? Track {
            searchImage = track.album?.images?.first?.url ?? ""
            searchTitle = track.name ?? ""
            searchSubtitle = "\(track.type?.capitalized ?? "") - \(track.artists?.first?.name ?? "")"
            cell.configure(image: searchImage, searchItemTitle: searchTitle, searchItemSubtitle: searchSubtitle)
        }
        
        return cell
    }
    
}

extension SearchViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = viewModel.allResults[indexPath.row]
        
        if let artistItem = item as? Artist {
            let vc = ArtistViewController()
            vc.configure(with: artistItem.id ?? "")
            navigationController?.pushViewController(vc, animated: true)
        } else if let albumItem = item as? Album {
            Task {
                let vc = PlaylistAlbumDetailViewController()
                
                let id = albumItem.id ?? ""
                let albumContent = await viewModel.getAlbumContent(albumID: id)
                let artist = await viewModel.getArtist(artistID: albumContent?.artists?.first?.id ?? "")
                print(id)
                let album = albumItem
                let albumTracks = albumContent?.tracks?.items
                
                var artists = [AddedBy]()
                
                albumTracks?.forEach { artists.append(contentsOf: $0.artists ?? []) }

                let fullInfoArtists = await viewModel.getFullInfoAboutArtist(artists: artists)
                
                vc.configure(tracks: albumTracks, album: album, artist: artist, otherArtists: fullInfoArtists)
                navigationController?.pushViewController(vc, animated: true)
            }
        } else if let trackItem = item as? Track {
            PlayerViewController.shared.startPlaySongs(songs: [trackItem.id ?? ""], at: 0)
            present(PlayerViewController.shared, animated: true)
        }
    }
    
}

extension SearchViewController {
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            searchContainer.topAnchor.constraint(equalTo: view.topAnchor),
            searchContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchContainer.bottomAnchor.constraint(equalTo: searchStackView.bottomAnchor, constant: 15),
            
            searchStackView.topAnchor.constraint(equalTo: searchContainer.safeAreaLayoutGuide.topAnchor, constant: 5),
            searchStackView.leadingAnchor.constraint(equalTo: searchContainer.leadingAnchor, constant: 15),
            searchStackView.trailingAnchor.constraint(equalTo: searchContainer.trailingAnchor, constant: -15),
            
            searchTextField.heightAnchor.constraint(equalToConstant: 30),
            
            cancelBtn.heightAnchor.constraint(equalToConstant: 30),
            
            collectionView.topAnchor.constraint(equalTo: searchContainer.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
}

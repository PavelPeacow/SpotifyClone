//
//  HomeViewController.swift
//  SpotifyClone
//
//  Created by Павел Кай on 19.01.2023.
//

import UIKit

class HomeViewController: UIViewController {
    
    let homeView = HomeView()
    let viewModel = HomeViewModel()
    
    override func loadView() {
        super.loadView()
        view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(Token.token ?? "no found")
        
        Task {
            await viewModel.getFeaturedPlaylists()
            await viewModel.getUserAlbums()
            homeView.collectionView.reloadData()
        }
        
        setDelegates()
    }
    
    private func setDelegates() {
        homeView.collectionView.delegate = self
        homeView.collectionView.dataSource = self
    }
    
}

extension HomeViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        Sections.allCases.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let section = Sections.allCases[section]

        switch section {
        case .featuredPlaylist:
            return viewModel.featuredPlaylist?.playlists.items.count ?? 0
        case .userAlbum:
            return viewModel.userAlbums?.items.count ?? 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identifier, for: indexPath) as! HomeCollectionViewCell
        
        let section = Sections.allCases[indexPath.section]
        
        switch section {
        case .featuredPlaylist:
            let title = viewModel.featuredPlaylist?.playlists.items[indexPath.row].name ?? ""
            let image = viewModel.featuredPlaylist?.playlists.items[indexPath.row].images.first?.url ?? ""
            cell.configure(with: title, imageURL: image)
        case .userAlbum:
            let title = viewModel.userAlbums?.items[indexPath.row].album.name ?? ""
            let image = viewModel.userAlbums?.items[indexPath.row].album.images?.first?.url ?? ""
            cell.configure(with: title, imageURL: image)
            break
        }
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionReusableView.identifier, for: indexPath) as! HeaderCollectionReusableView

        let section = Sections.allCases[indexPath.section]
        
        switch section {
        case .featuredPlaylist:
            header.setTitle(with: viewModel.featuredPlaylistSectionTitle)
        case .userAlbum:
            header.setTitle(with: section.title)
        }
        
        return header
    }

}

extension HomeViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.animateTap(scale: 0.95)
        
        switch Sections.allCases[indexPath.section] {
        case .featuredPlaylist:
            Task {
                let vc = PlaylistAlbumDetailViewController()
                let id = viewModel.featuredPlaylist?.playlists.items[indexPath.row].id ?? ""
                let tracks = await viewModel.getPlaylistContent(playlistID: id)
                
                var tracksArray = [Track]()
                tracks?.items.forEach {
                    tracksArray.append($0.track)
                }
                
                vc.configure(tracks: tracksArray)
                navigationController?.pushViewController(vc, animated: true)
            }
        case .userAlbum:
            Task {
                let vc = PlaylistAlbumDetailViewController()
                let album = viewModel.userAlbums?.items[indexPath.row].album
                let tracks = viewModel.userAlbums?.items[indexPath.row].album.tracks?.items
                vc.configure(tracks: tracks, album: album)
                navigationController?.pushViewController(vc, animated: true)
            }
        }
    }

}

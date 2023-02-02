//
//  HomeViewController.swift
//  SpotifyClone
//
//  Created by Павел Кай on 19.01.2023.
//

import UIKit

class HomeViewController: UIViewController {
    
    private let homeView = HomeView()
    private let viewModel = HomeViewModel()
    
    override func loadView() {
        super.loadView()
        view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(Token.shared.token ?? "no found")
        
        Task {
            await viewModel.getFeaturedPlaylists()
            await viewModel.getUserAlbums()
            await viewModel.getRecentlyPlayed()
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
            return viewModel.featuredPlaylist.count
        case .userAlbum:
            return viewModel.userAlbums.count
        case .recentlyPlayed:
            return viewModel.recentlyPlayed.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identifier, for: indexPath) as! HomeCollectionViewCell
        
        let section = Sections.allCases[indexPath.section]
        
        switch section {
        case .featuredPlaylist:
            let title = viewModel.featuredPlaylist[indexPath.row].name
            let image = viewModel.featuredPlaylist[indexPath.row].images.first?.url ?? ""
            cell.configure(with: title, imageURL: image)
        case .userAlbum:
            let title = viewModel.userAlbums[indexPath.row].album.name ?? ""
            let image = viewModel.userAlbums[indexPath.row].album.images?.first?.url ?? ""
            cell.configure(with: title, imageURL: image)
            break
        case .recentlyPlayed:
            let title = viewModel.recentlyPlayed[indexPath.row].track.album?.name ?? ""
            let image = viewModel.recentlyPlayed[indexPath.row].track.album?.images?.first?.url ?? ""
            cell.configure(with: title, imageURL: image)
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
        case .recentlyPlayed:
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
                let playlist = viewModel.featuredPlaylist[indexPath.row]
                let id = playlist.id
                let tracks = await viewModel.getPlaylistContent(playlistID: id)
                
                var tracksArray = [Track]()
                tracks?.forEach {
                    tracksArray.append($0.track)
                }
                
                vc.configure(tracks: tracksArray, playlist: playlist)
                navigationController?.pushViewController(vc, animated: true)
            }
        case .userAlbum:
            let vc = PlaylistAlbumDetailViewController()
            let album = viewModel.userAlbums[indexPath.row].album
            let tracks = viewModel.userAlbums[indexPath.row].album.tracks?.items
            vc.configure(tracks: tracks, album: album)
            navigationController?.pushViewController(vc, animated: true)
        case .recentlyPlayed:
            Task {
                let vc = PlaylistAlbumDetailViewController()
                
                let id = viewModel.recentlyPlayed[indexPath.row].track.album?.id ?? ""
                let albumContent = await viewModel.getAlbumContent(albumID: id)
                
                let album = viewModel.recentlyPlayed[indexPath.row].track.album
                let albumTracks = albumContent?.tracks?.items
                
                vc.configure(tracks: albumTracks, album: album)
                navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
}

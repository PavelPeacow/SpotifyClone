//
//  AlbumDetailViewController.swift
//  SpotifyClone
//
//  Created by Павел Кай on 28.01.2023.
//

import UIKit

enum CellType {
    case album
    case playlist
}

final class PlaylistAlbumDetailViewController: UIViewController {
    
    private let albumDetailView = PlaylistAlbumDetailView()
    private let viewModel = PlaylistAlbumDetailViewModel()
    
    private var type: CellType = .playlist
    
    override func loadView() {
        super.loadView()
        view = albumDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegates()
    }
    
    private func setDelegates() {
        albumDetailView.collectionView.delegate = self
        albumDetailView.collectionView.dataSource = self
    }
    
    func configure(tracks: [Track]?, album: Album? = nil, playlist: PlaylistItem? = nil) {
        guard let tracks = tracks else { return }
        
        if let _ = album {
            type = .album
        } else {
            type = .playlist
        }
        print(viewModel.tracks)
        
        let coverURL: String
        
        switch type {
        case .album:
            viewModel.album = album
            coverURL = viewModel.album?.images?.first?.url ?? ""
        case .playlist:
            viewModel.playlist = playlist
            coverURL = viewModel.playlist?.images.first?.url ?? ""
        }
        
        viewModel.tracks = tracks
        albumDetailView.collectionView.reloadData()
        
        albumDetailView.floatingCover.setCover(with: coverURL) { [weak self] in
            self?.setGradientColorsAndBackground()
        }
        
    }
    
    private func setGradientColorsAndBackground() {
        let averageColor = albumDetailView.floatingCover.cover.image?.averageColor ?? .green
        albumDetailView.gradient.colors = [
            averageColor.cgColor,
            UIColor.black.cgColor,
        ]
        albumDetailView.backgroundColor = averageColor
        albumDetailView.container.backgroundColor = averageColor
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        albumDetailView.gradient.frame = albumDetailView.floatingCover.bounds
    }
    
}

extension PlaylistAlbumDetailViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.tracks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlaylistAlbumDetailViewCell.identifier, for: indexPath) as! PlaylistAlbumDetailViewCell
        
        let track = viewModel.tracks[indexPath.row]
        
        let title: String
        let grouptTitle: String
        let image: String?
        
        switch type {
            
        case .album:
            title = track.name ?? ""
            grouptTitle = viewModel.album?.artists?.first?.name ?? ""
            image = nil
        case .playlist:
            title = track.name ?? ""
            grouptTitle = track.artists?.first?.name ?? ""
            image = track.album?.images?.first?.url ?? ""
        }
        
        cell.configure(imageURL: image, trackTitle: title, groupTitle: grouptTitle)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: PlaylistAlbumHeaderCollectionReusableView.identifier, for: indexPath) as! PlaylistAlbumHeaderCollectionReusableView
        
        let title: String
        let date: String
        let itemType: String
        
        switch type {
            
        case .album:
            title = viewModel.album?.name ?? ""
            date = viewModel.album?.releaseDate ?? ""
            itemType = viewModel.album?.type ?? ""
            header.setCover(title: title, typeAndDate: "\(itemType.capitalized) - \(date.prefix(4))")
        case .playlist:
            title = viewModel.playlist?.description ?? ""
            date = viewModel.playlist?.owner.displayName ?? ""
            itemType = viewModel.playlist?.type ?? ""
            header.setCover(title: title, typeAndDate: "\(itemType.capitalized) - \(date)")
        }
        
        print(title)
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        CGSize(width: view.frame.width, height: 350)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        albumDetailView.floatingCover.scrollViewDidScroll(scrollView: scrollView)
    }
    
}

extension PlaylistAlbumDetailViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: view.frame.width, height: 50)
    }
    
}

extension PlaylistAlbumDetailViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let song = viewModel.tracks[indexPath.row]
        let id = song.id ?? ""
        print(id)
        PlayerViewController.shared.startPlaySong(song: id)
        present(PlayerViewController.shared, animated: true)
    }
    
}

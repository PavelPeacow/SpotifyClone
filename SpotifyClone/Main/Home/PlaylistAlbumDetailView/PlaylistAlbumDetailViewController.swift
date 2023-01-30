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
    
    func configure(tracks: [Track]?, album: Album? = nil) {
        guard let tracks = tracks else { return }
        viewModel.tracks = tracks
        viewModel.album = album
        print(viewModel.tracks)
        albumDetailView.collectionView.reloadData()
    }
    
}

extension PlaylistAlbumDetailViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.tracks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlaylistAlbumDetailViewCell.identifier, for: indexPath) as! PlaylistAlbumDetailViewCell
        
        let track = viewModel.tracks[indexPath.row]
        var cellType: CellType = .playlist

        let title = track.name ?? ""
        var grouptTitle = track.album?.artists?.first?.name ?? ""
        var image = track.album?.images?.first?.url ?? ""
        
        if let album = viewModel.album {
            image = album.images?.first?.url ?? ""
            grouptTitle = album.artists?.first?.name ?? ""
            cellType = .album
        }
        
        cell.configure(imageURL: image, trackTitle: title, groupTitle: grouptTitle, cellType: cellType)
        return cell
    }
        
}

extension PlaylistAlbumDetailViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: view.frame.width, height: 50)
    }
    
}

extension PlaylistAlbumDetailViewController: UICollectionViewDelegate {
    
}

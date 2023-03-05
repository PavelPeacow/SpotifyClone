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
    let viewModel = PlaylistAlbumDetailViewModel()
    
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
        PlayerViewController.shared.trackUpdater = self
    }
    
#warning("TODO: probably need its own model to input")
    func configure(tracks: [Track]?, album: Album? = nil, playlist: PlaylistItem? = nil, artist: Artist? = nil, user: User? = nil) {
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
            viewModel.artist = artist
        case .playlist:
            viewModel.playlist = playlist
            coverURL = viewModel.playlist?.images.first?.url ?? ""
            viewModel.user = user
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
            UIColor.mainBackground.cgColor,
        ]
        albumDetailView.backgroundColor = averageColor
        albumDetailView.container.backgroundColor = averageColor
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let header = albumDetailView.collectionView.supplementaryView(forElementKind: UICollectionView.elementKindSectionHeader, at: IndexPath(item: 0, section: 0)) as? PlaylistAlbumHeaderCollectionReusableView {
            header.isPlayingThisAlbum()
        }
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        albumDetailView.gradient.frame = albumDetailView.floatingCover.bounds
    }
    
}

extension PlaylistAlbumDetailViewController: PlayerViewControllerNewTrackUpdater {
    
    func didStartPlayNewTrack(_ id: String) {
        let cellId = viewModel.tracks.firstIndex(where: { $0.id == id }) ?? 0
        let indexPath = IndexPath(item: cellId, section: 0)
        
        guard let cellToUpadte = albumDetailView.collectionView.cellForItem(at: indexPath) as? PlaylistAlbumDetailViewCell else { return }

        if let currentPlayingCell = viewModel.currentPlayingCell {
            if currentPlayingCell != cellToUpadte {
                viewModel.currentPlayingCell?.setNonPlayingState()
                viewModel.currentPlayingCell = cellToUpadte
            }
        } else {
            viewModel.currentPlayingCell = cellToUpadte
        }
        
        cellToUpadte.setPlayingState()
    }
    
}

extension PlaylistAlbumDetailViewController: PlaylistAlbumHeaderCollectionReusableViewDelegate {
    
    func didTapArtist() {
        switch type {
            
        case .album:
            let vc = ArtistViewController()
            vc.configure(with: viewModel.artist?.id ?? "")
            navigationController?.pushViewController(vc, animated: true)
        case .playlist:
#warning("TODO: ProfileView")
            print("Need to do profileView")
        }
        
    }
    
    func didTapPlayBtn(_ isTap: Bool) {
        if isTap {
            switch type {
                
            case .album:
                PlayerViewController.shared.viewModel.playlistIdOfPlayingTrack = nil
            case .playlist:
                PlayerViewController.shared.viewModel.playlistIdOfPlayingTrack = viewModel.playlist?.id
            }
            
            let songs = viewModel.tracks.map( {$0.id ?? "" })
            PlayerViewController.shared.startPlaySongs(songs: songs, at: 0)
            present(PlayerViewController.shared, animated: true)
        } else {
            PlayerViewController.shared.pauseFromBottomPlayerView()
            viewModel.currentPlayingCell?.setNonPlayingState()
            viewModel.currentPlayingCell = nil
        }
        
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
        cell.trackID = track.id
        cell.isPlayingState()
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: PlaylistAlbumHeaderCollectionReusableView.identifier, for: indexPath) as! PlaylistAlbumHeaderCollectionReusableView
        
        header.delegate = self
        
        let title: String
        let date: String
        let itemType: String
        let artistImage: String
        let artistTitle: String
        
        switch type {
            
        case .album:
            title = viewModel.album?.name ?? ""
            date = viewModel.album?.releaseDate ?? ""
            itemType = viewModel.album?.albumType ?? ""
            artistImage = viewModel.artist?.images?.first?.url ?? ""
            artistTitle = viewModel.artist?.name ?? ""
            
            header.id = viewModel.album?.id ?? ""
            
            header.setCover(title: title, typeAndDate: "\(itemType.capitalized) - \(date.prefix(4))", artistImage: artistImage, artistTitle: artistTitle)
        case .playlist:
            title = viewModel.playlist?.description ?? ""
            date = viewModel.playlist?.owner.displayName ?? ""
            itemType = viewModel.playlist?.type ?? ""
            artistImage = viewModel.user?.images?.first?.url ?? ""
            artistTitle = viewModel.user?.displayName ?? ""
            
            header.id = viewModel.playlist?.id ?? ""
            
            let playlistTime = viewModel.tracks.reduce(into: 0, { $0 += $1.durationMS ?? 0 })
            let formattedTime = viewModel.convertSecondsToHrMinute(miliseconds: playlistTime)
            header.setCover(title: title, typeAndDate: "\(formattedTime)", artistImage: artistImage, artistTitle: artistTitle)
        }
        
        header.isPlayingThisAlbum()
        
        print(title)
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        CGSize(width: view.frame.width, height: 400)
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
        let tracksID = viewModel.tracks.map { Track in
            Track.id ?? ""
        }
        
        print(tracksID)
        
        switch type {
            
        case .album:
            PlayerViewController.shared.viewModel.playlistIdOfPlayingTrack = nil
        case .playlist:
            PlayerViewController.shared.viewModel.playlistIdOfPlayingTrack = viewModel.playlist?.id
        }
        
        if let header = albumDetailView.collectionView.supplementaryView(forElementKind: UICollectionView.elementKindSectionHeader, at: IndexPath(item: 0, section: 0)) as? PlaylistAlbumHeaderCollectionReusableView {
            header.didStartPlayTappedSong()
        }
        
        PlayerViewController.shared.startPlaySongs(songs: tracksID, at: indexPath.row)
        present(PlayerViewController.shared, animated: true)
    }
    
}

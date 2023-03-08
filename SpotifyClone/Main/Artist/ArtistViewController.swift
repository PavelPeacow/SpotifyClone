//
//  ArtistViewController.swift
//  SpotifyClone
//
//  Created by Павел Кай on 14.02.2023.
//

import UIKit

final class ArtistViewController: UIViewController {
    
    let artistView = ArtistView()
    let viewModel = ArtistViewModel()
    
    override func loadView() {
        view = artistView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setDelegates()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        #warning("Reset custom navBar")
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem()
    }
    
    private func setDelegates() {
        artistView.collectionView.delegate = self
        artistView.collectionView.dataSource = self
    }
    
    func configure(with artistID: String) {
        Task {
            await viewModel.getArtist(artistID: artistID)
            await viewModel.getArtistTopTracks(artistID: artistID)
            await viewModel.getArtistAlbums(artistID: artistID)
            artistView.collectionView.reloadData()
        }
    }

}

extension ArtistViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        ArtistSections.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch ArtistSections.allCases[section] {
            
        case .mainHeader:
            return 0
        case .popularTracks:
            return viewModel.popularTracks.count
        case .albums:
            return viewModel.albums.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch ArtistSections.allCases[indexPath.section] {
            
        case .mainHeader:
            return UICollectionViewCell()
        case .popularTracks:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ArtistTopTracksCollectionViewCell.identifier, for: indexPath) as! ArtistTopTracksCollectionViewCell
            
            cell.configure(with: viewModel.popularTracks[indexPath.row].name ?? "", imageURL: viewModel.popularTracks[indexPath.row].album?.images?.first?.url ?? "")
            
            return cell
        case .albums:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ArtistAlbumCollectionViewCell.identifier, for: indexPath) as! ArtistAlbumCollectionViewCell
            
            let album = viewModel.albums[indexPath.row]
            
            cell.configure(albumCover: album.images?.first?.url ?? "", albumTitle: album.name ?? "", type: album.albumType ?? "", date: album.releaseDate ?? "")
            
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let section = ArtistSections.allCases[indexPath.section]
        
        switch section {
            
        case .mainHeader:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ArtistHeaderReusableView.identifier, for: indexPath) as! ArtistHeaderReusableView
            header.configure(with: viewModel.artist?.name ?? "", imageURL: viewModel.artist?.images?.first?.url ?? "")
            return header
        case .popularTracks:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionReusableView.identifier, for: indexPath) as! HeaderCollectionReusableView
            header.setTitle(with: section.title ?? "")
            return header
        case .albums:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionReusableView.identifier, for: indexPath) as! HeaderCollectionReusableView
            header.setTitle(with: section.title ?? "")
            return header
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let header = artistView.collectionView.supplementaryView(forElementKind: UICollectionView.elementKindSectionHeader, at: IndexPath(item: 0, section: 0)) as? ArtistHeaderReusableView {
                    header.scrollViewDidScroll(scrollView: artistView.collectionView)
         }
    }
    
    
}

extension ArtistViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.animateTap(scale: 0.95)
        
        switch ArtistSections.allCases[indexPath.section] {
            
        case .mainHeader:
            return
        case .popularTracks:
            Task {
                let track = viewModel.popularTracks[indexPath.row]
                let id = track.album?.id ?? ""
                
                let albumContent = await viewModel.getAlbumContent(albumID: id)
                
                let tracks = albumContent?.tracks?.items.map { $0.id ?? "" }
                
                PlayerViewController.shared.startPlaySongs(songs: tracks ?? [], at: (track.trackNumber ?? 0) - 1)
                present(PlayerViewController.shared, animated: true)
            }
        case .albums:
            Task {
                let album = viewModel.albums[indexPath.row]
                let id = album.id ?? ""
                
                let albumContent = await viewModel.getAlbumContent(albumID: id)
                
                let tracks = albumContent?.tracks?.items
                
                var artists = [AddedBy]()
                
                tracks?.forEach { artists.append(contentsOf: $0.artists ?? []) }

                let fullInfoArtists = await viewModel.getFullInfoAboutArtist(artists: artists)
                
                let vc = PlaylistAlbumDetailViewController()
                vc.configure(tracks: tracks, album: album, artist: viewModel.artist, otherArtists: fullInfoArtists)
                navigationController?.pushViewController(vc, animated: true)
            }
           
        }
        
    }
    
}

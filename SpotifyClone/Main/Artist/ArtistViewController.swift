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
    
    private func setDelegates() {
        artistView.collectionView.delegate = self
        artistView.collectionView.dataSource = self
    }
    
    func configure(with artistID: String) {
        Task {
            await viewModel.getArtist(artistID: artistID)
            await viewModel.getArtistTopTracks(artistID: artistID)
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
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let header = artistView.collectionView.supplementaryView(forElementKind: UICollectionView.elementKindSectionHeader, at: IndexPath(item: 0, section: 0)) as? ArtistHeaderReusableView {
                    header.scrollViewDidScroll(scrollView: artistView.collectionView)
         }
    }
    
    
}

extension ArtistViewController: UICollectionViewDelegate {
    
}

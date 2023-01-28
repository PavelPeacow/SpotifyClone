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
            await viewModel.getNewReleases()
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
        case .newReleases:
            return viewModel.newReleases.count
        case .userAlbum:
            return viewModel.userAlbums.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identifier, for: indexPath) as! HomeCollectionViewCell
        
        let section = Sections.allCases[indexPath.section]
        
        switch section {
        case .featuredPlaylist:
            let title = viewModel.featuredPlaylist[indexPath.row].name ?? ""
            let image = viewModel.featuredPlaylist[indexPath.row].images.first?.url ?? ""
            cell.configure(with: title, imageURL: image)
        case .newReleases:
            let title = viewModel.newReleases[indexPath.row].name ?? ""
            let image = viewModel.newReleases[indexPath.row].images.first?.url ?? ""
            cell.configure(with: title, imageURL: image)
        case .userAlbum:
            let title = viewModel.userAlbums[indexPath.row].album.label
            let image = viewModel.userAlbums[indexPath.row].album.images.first?.url ?? ""
            cell.configure(with: title, imageURL: image)
        }
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionReusableView.identifier, for: indexPath) as! HeaderCollectionReusableView

        let section = Sections.allCases[indexPath.section]
        
        switch section {
        case .featuredPlaylist:
            header.setTitle(with: section.title)
        case .newReleases:
            header.setTitle(with: section.title)
        case .userAlbum:
            header.setTitle(with: section.title)
        }
        
        return header
    }

}

extension HomeViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }

}

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
        switch Sections.allCases[section] {
        case .featuredPlaylist:
            return viewModel.featuredPlaylist.count
        case .popularPlaylist:
            return viewModel.popularPlaylist.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identifier, for: indexPath) as! HomeCollectionViewCell
        
        let title = viewModel.featuredPlaylist[indexPath.row].name ?? ""
        let image = viewModel.featuredPlaylist[indexPath.row].images.first?.url ?? ""
        
        cell.configure(with: title, imageURL: image)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionReusableView.identifier, for: indexPath) as! HeaderCollectionReusableView

        switch Sections.allCases[indexPath.section] {
        case .featuredPlaylist:
            header.setTitle(with: "Featured")
        case .popularPlaylist:
            header.setTitle(with: "Popular")
        }
        
        return header
    }

}

extension HomeViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }

}

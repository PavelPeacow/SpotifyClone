//
//  CategoryViewController.swift
//  SpotifyClone
//
//  Created by Павел Кай on 10.03.2023.
//

import UIKit

class CategoryViewController: UIViewController {
    
    lazy var pinnedSearchViewContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .mainBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()
    
    lazy var pinnedSearchView: CategorySearchView = {
        let view = CategorySearchView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewCompositionalLayout { Int, env in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
            
            let item = NSCollectionLayoutItem(layoutSize: itemSize)

            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(100))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
            group.interItemSpacing = .fixed(15)

            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: 15, leading: 15, bottom: 15, trailing: 15)
            section.interGroupSpacing = 15
            
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(100))
            let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
            section.boundarySupplementaryItems = [header]

            return section

        }
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
        collectionView.register(CategoryHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CategoryHeaderCollectionReusableView.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .mainBackground
        collectionView.contentInsetAdjustmentBehavior = .never
        return collectionView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
        navigationItem.compactAppearance = appearance

        view.addSubview(collectionView)
        
        collectionView.addSubview(pinnedSearchViewContainer)
        pinnedSearchViewContainer.addSubview(pinnedSearchView)
        
        view.backgroundColor = .mainBackground
        
        setConstraints()
        setDelegates()
    }
    
    private func setDelegates() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
}

extension CategoryViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as! CategoryCollectionViewCell
        
        cell.configure(title: "Rock", image: "")
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CategoryHeaderCollectionReusableView.identifier, for: indexPath) as! CategoryHeaderCollectionReusableView
        
        return header
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let header = collectionView.supplementaryView(forElementKind: UICollectionView.elementKindSectionHeader, at: IndexPath(item: 0, section: 0)) as? CategoryHeaderCollectionReusableView {
            if scrollView.contentOffset.y > header.categorySearchView.frame.minY {
                pinnedSearchView.isHidden = false
                pinnedSearchViewContainer.isHidden = false
            } else {
                pinnedSearchView.isHidden = true
                pinnedSearchViewContainer.isHidden = true
            }
         }
        
       
    }
    
}

extension CategoryViewController: UICollectionViewDelegate {
    
}

extension CategoryViewController {
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            pinnedSearchViewContainer.topAnchor.constraint(equalTo: view.topAnchor),
            pinnedSearchViewContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pinnedSearchViewContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pinnedSearchViewContainer.bottomAnchor.constraint(equalTo: pinnedSearchView.bottomAnchor, constant: 15),
            
            pinnedSearchView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            pinnedSearchView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            pinnedSearchView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            pinnedSearchView.heightAnchor.constraint(equalToConstant: 35),

            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
}

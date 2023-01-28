//
//  CompLayoutSections.swift
//  SpotifyClone
//
//  Created by Павел Кай on 27.01.2023.
//

import UIKit

enum Sections: CaseIterable {
    case featuredPlaylist
    case newReleases
    case userAlbum
    
    var title: String {
        switch self {
        case .featuredPlaylist:
            return "Featured"
        case .newReleases:
            return "New Releases"
        case .userAlbum:
            return "Your albums"
        }
    }
}

extension UICollectionViewCompositionalLayout {
    
    static func createSections() -> UICollectionViewCompositionalLayout {
        
        return UICollectionViewCompositionalLayout { sectionIndex, _ in
            switch Sections.allCases[sectionIndex] {
            case .featuredPlaylist:
                return .createHomeSection()
            case .newReleases:
                return .createSecondSection()
            case .userAlbum:
                return .createSecondSection()
            }
        }
        
    }
    
}

extension NSCollectionLayoutSection {

    static func createHomeSection() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(150), heightDimension: .absolute(150))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        
        section.contentInsets = .init(top: 15, leading: 15, bottom: 15, trailing: 15)
        section.interGroupSpacing = 15
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(20))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        
        section.boundarySupplementaryItems = [header]

        return section
    }
    
    static func createSecondSection() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(200), heightDimension: .absolute(180))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        
        section.contentInsets = .init(top: 15, leading: 15, bottom: 15, trailing: 15)
        section.interGroupSpacing = 15
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(20))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        
        section.boundarySupplementaryItems = [header]
        
        return section
    }
    
}

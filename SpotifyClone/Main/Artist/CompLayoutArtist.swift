//
//  CompLayoutArtist.swift
//  SpotifyClone
//
//  Created by Павел Кай on 14.02.2023.
//

import UIKit

enum ArtistSections: CaseIterable {
    case mainHeader
    case popularTracks
    
    var title: String? {
        switch self {
        case .mainHeader:
            return nil
        case .popularTracks:
            return "Popular Tracks"
        }
    }

}

extension NSCollectionLayoutSection {
    
    static func createHeader() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(0), heightDimension: .absolute(0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(0), heightDimension: .absolute(0))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        section.contentInsets = .init(top: 15, leading: 0, bottom: 15, trailing: 0)
        section.interGroupSpacing = 15
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(350))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)

        section.boundarySupplementaryItems = [header]
        
        return section
    }
    
    static func createArtistTopTracksSection() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(300), heightDimension: .estimated(300))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .fixed(15)
        
        let section = NSCollectionLayoutSection(group: group)
        
        section.contentInsets = .init(top: 15, leading: 0, bottom: 15, trailing: 0)
        section.interGroupSpacing = 15
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(20))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        
        section.boundarySupplementaryItems = [header]
        
        return section
    }
    
}

extension UICollectionViewCompositionalLayout {
    
    static func createSectionsForArtist() -> UICollectionViewCompositionalLayout {
        
        return UICollectionViewCompositionalLayout { sectionIndex, _ in
            switch ArtistSections.allCases[sectionIndex] {
            case .mainHeader:
                return .createHeader()
            case .popularTracks:
                return .createArtistTopTracksSection()
            }
        }
        
    }
}

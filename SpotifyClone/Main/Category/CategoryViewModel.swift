//
//  CategoryViewModel.swift
//  SpotifyClone
//
//  Created by Павел Кай on 11.03.2023.
//

import Foundation

class CategoryViewModel {
    
    var categories = [CategoriesItem]()
    var playlistsImagesUrl = [String]()
    
    func getCategories() async {
        do {
            let result = try await APIManager().getSpotifyContent(type: CategoriesResponse.self, endpoint: CategoryEndpoint.getCategories)
            categories = result.categories.items
        } catch {
            print(error)
        }
    }
    
    func getCategoryPlaylists(categoryId: String, limit: String = "30") async -> Playlists? {
        do {
            let result = try await APIManager().getSpotifyContent(type: FeaturedPlaylists.self, endpoint: CategoryEndpoint.getCategoryPlaylists(categoryId: categoryId, limit: limit))
            return result.playlists
        } catch {
            print(error)
            return nil
        }
    }
    
    func getCategoriesImages() async {
        let categoriesID = categories.map( { $0.id })
        
        await withTaskGroup(of: (id: String, imageUrl: String?).self ) { group in
            for id in categoriesID {
                group.addTask {
                    let categoryPlaylist = await self.getCategoryPlaylists(categoryId: id, limit: "1")
                    
                    if let url = categoryPlaylist?.items.first?.images.last?.url {
                        return (id, url)
                    } else {
                        let index = self.categories.firstIndex(where: { $0.id == id })
                        self.categories.remove(at: index!)
                        return (id, nil)
                    }
                    
                }
            }
            
            let dictionary = await group.reduce(into: [:]) { $0[$1.id] = $1.imageUrl }
            
            playlistsImagesUrl = categoriesID.compactMap { dictionary[$0] }
        }
        
        
    }
    
}

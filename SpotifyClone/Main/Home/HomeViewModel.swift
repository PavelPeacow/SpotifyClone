//
//  HomeViewModel.swift
//  SpotifyClone
//
//  Created by Павел Кай on 27.01.2023.
//

import Foundation

final class HomeViewModel {
    
    var featuredPlaylist = [FeaturedPlaylist]()
    var popularPlaylist = [String]()
    
    func getFeaturedPlaylists() async {
            do {
                let result = try await APIManager().getSpotifyContent(type: FeaturedPlaylistsResponse.self, endpoint: .getFeaturedPlaylists)
                featuredPlaylist = result.playlists.items
                print(result)
            } catch {
                print(error)
            }
    }
    
}

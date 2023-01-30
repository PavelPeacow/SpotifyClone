//
//  HomeViewModel.swift
//  SpotifyClone
//
//  Created by Павел Кай on 27.01.2023.
//

import Foundation

final class HomeViewModel {
    
    var featuredPlaylistSectionTitle = ""
    
    var featuredPlaylist: FeaturedPlaylists?
    var userAlbums: CurrentUserAlbums?
    
    func getFeaturedPlaylists() async {
        do {
            let result = try await APIManager().getSpotifyContent(type: FeaturedPlaylists.self, endpoint: ContentEndpoint.getFeaturedPlaylists)
            featuredPlaylist = result
            featuredPlaylistSectionTitle = result.message
            print(result)
        } catch {
            print(error)
        }
    }
    
    func getUserAlbums() async {
        do {
            let result = try await APIManager().getSpotifyContent(type: CurrentUserAlbums.self, endpoint: ContentEndpoint.getUserAlbum)
            userAlbums = result
            print(result.items)
        } catch {
            print(error)
        }
    }

    func getPlaylistContent(playlistID: String) async -> PlaylistContent? {
        do {
            let result = try await APIManager().getSpotifyContent(type: PlaylistContent.self, endpoint: ContentEndpoint.getPlaylistContent(playlistID: playlistID))
            return result
        } catch {
            print(error)
            return nil
        }
    }

}

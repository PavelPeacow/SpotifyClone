//
//  HomeViewModel.swift
//  SpotifyClone
//
//  Created by Павел Кай on 27.01.2023.
//

import Foundation

final class HomeViewModel {
    
    var featuredPlaylist = [FeaturedPlaylist]()
    var newReleases = [NewAlbumContent]()
    var userAlbums = [UserAlbum]()
    
    func getFeaturedPlaylists() async {
        do {
            let result = try await APIManager().getSpotifyContent(type: FeaturedPlaylistsResponse.self, endpoint: ContentEndpoint.getFeaturedPlaylists)
            featuredPlaylist = result.playlists.items
            print(result)
        } catch {
            print(error)
        }
    }
    
    func getNewReleases() async {
        do {
            let result = try await APIManager().getSpotifyContent(type: NewAlbumReleaseResponse.self, endpoint: ContentEndpoint.getNewReleases)
            newReleases = result.albums.items
        } catch {
            print(error)
        }
    }
    
    func getUserAlbums() async {
        do {
            let result = try await APIManager().getSpotifyContent(type: UserAlbumItems.self, endpoint: ContentEndpoint.getUserAlbum)
            userAlbums = result.items
            print(result.items)
        } catch {
            print(error)
        }
    }
    
}

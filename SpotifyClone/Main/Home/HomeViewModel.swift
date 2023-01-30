//
//  HomeViewModel.swift
//  SpotifyClone
//
//  Created by Павел Кай on 27.01.2023.
//

import Foundation

final class HomeViewModel {
    
    var featuredPlaylistSectionTitle = ""
    
    var recentlyPlayed = [RecentlyPlayedItem]()
    
    var featuredPlaylist = [PlaylistItem]()
    var userAlbums = [CurrentUserAlbumsItem]()
    
    func removeDuplicates(from tracks: [RecentlyPlayedItem]) -> [RecentlyPlayedItem] {
        var dictionary: [String:Bool] = [:]
        return tracks.filter {
            dictionary.updateValue(true, forKey: $0.track.album?.id ?? "") == nil
        }
    }
    
    //MARK: API calls
    func getFeaturedPlaylists() async {
        do {
            let result = try await APIManager().getSpotifyContent(type: FeaturedPlaylists.self, endpoint: ContentEndpoint.getFeaturedPlaylists)
            featuredPlaylist = result.playlists.items
            featuredPlaylistSectionTitle = result.message
        } catch {
            print(error)
        }
    }
    
    func getUserAlbums() async {
        do {
            let result = try await APIManager().getSpotifyContent(type: CurrentUserAlbums.self, endpoint: ContentEndpoint.getUserAlbum)
            userAlbums = result.items
        } catch {
            print(error)
        }
    }
    
    func getRecentlyPlayed() async {
        do {
            let result = try await APIManager().getSpotifyContent(type: RecentlyPlayed.self, endpoint: ContentEndpoint.getRecentlyPlayed)
            recentlyPlayed = removeDuplicates(from: result.items)
        } catch {
            print(error)
        }
    }

    func getPlaylistContent(playlistID: String) async -> [PlaylistContentItem]? {
        do {
            let result = try await APIManager().getSpotifyContent(type: PlaylistContent.self, endpoint: ContentEndpoint.getPlaylistContent(playlistID: playlistID))
            return result.items
        } catch {
            print(error)
            return nil
        }
    }
    
    func getAlbumContent(albumID: String) async -> AlbumContent? {
        do {
            let result = try await APIManager().getSpotifyContent(type: AlbumContent.self, endpoint: ContentEndpoint.getAlbum(albumID: albumID))
            return result
        } catch {
            print(error)
            return nil
        }
    }

}

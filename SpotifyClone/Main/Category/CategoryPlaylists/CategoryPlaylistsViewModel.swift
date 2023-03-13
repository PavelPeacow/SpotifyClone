//
//  CategoryPlaylistsViewModel.swift
//  SpotifyClone
//
//  Created by Павел Кай on 13.03.2023.
//

import Foundation

class CategoryPlaylistsViewModel {
    
    var categoryPlaylits = [PlaylistItem]()
    
    func getPlaylistContent(playlistID: String) async -> [PlaylistContentItem]? {
        do {
            let result = try await APIManager().getSpotifyContent(type: PlaylistContent.self, endpoint: ContentEndpoint.getPlaylistContent(playlistID: playlistID))
            return result.items
        } catch {
            print(error)
            return nil
        }
    }
    
    func getUser(userID: String) async -> User? {
        do {
            let result = try await APIManager().getSpotifyContent(type: User.self, endpoint: UserEndpoint.getUser(id: userID))
            return result
        } catch {
            print(error)
            return nil
        }
    }
    
}

//
//  LibraryViewModel.swift
//  SpotifyClone
//
//  Created by Павел Кай on 02.04.2023.
//

import Foundation

class LibraryViewModel {
    
    var userAlbums = [CurrentUserAlbumsItem]()
    
    func getCurrentUserAlbums() async {
        do {
            let result = try await APIManager().getSpotifyContent(type: CurrentUserAlbums.self, endpoint: ContentEndpoint.getUserAlbum)
            userAlbums = result.items
        } catch {
            print(error)
        }
    }
    
}

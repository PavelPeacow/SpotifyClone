//
//  ArtistViewModel.swift
//  SpotifyClone
//
//  Created by Павел Кай on 14.02.2023.
//

import Foundation

final class ArtistViewModel {
    
    var popularTracks = [Track]()
    var artist: Artist?
    
    func getArtist(artistID: String) async {
        do {
            let result = try await APIManager().getSpotifyContent(type: Artist.self, endpoint: ArtistEndpoint.getArtist(id: artistID))
            artist = result
        } catch {
            print(error)
        }
    }
    
    func getArtistTopTracks(artistID: String) async {
        do {
            let result = try await APIManager().getSpotifyContent(type: ArtistPopularTracks.self, endpoint: ArtistEndpoint.getArtistTopTracks(id: artistID))
            popularTracks = result.tracks
        } catch {
            print(error)
        }
    }

    
}

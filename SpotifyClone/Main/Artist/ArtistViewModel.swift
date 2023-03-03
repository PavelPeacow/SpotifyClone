//
//  ArtistViewModel.swift
//  SpotifyClone
//
//  Created by Павел Кай on 14.02.2023.
//

import Foundation

final class ArtistViewModel {
    
    var popularTracks = [Track]()
    var albums = [Album]()
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
    
    func getArtistAlbums(artistID: String) async {
        do {
            let result = try await APIManager().getSpotifyContent(type: ArtistAlbums.self, endpoint: ArtistEndpoint.getArtistAlbums(id: artistID))
            albums = result.items
        } catch {
            print(error)
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

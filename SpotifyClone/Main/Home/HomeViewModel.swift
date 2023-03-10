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
            featuredPlaylistSectionTitle = result.message ?? ""
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
            recentlyPlayed = result.items
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
    
    func getArtist(artistID: String) async -> Artist? {
        do {
            let result = try await APIManager().getSpotifyContent(type: Artist.self, endpoint: ArtistEndpoint.getArtist(id: artistID))
            return result
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
    
    func getFullInfoAboutArtist(artists: [AddedBy]) async -> [Artist] {
        let artists = artists.uniques(by: \.name).sorted(by: { $0.name ?? "" < $1.name ?? "" })
        var fullInfoArtits = [Artist]()
        
        await withTaskGroup(of: Artist?.self, body: { group in
            for artID in artists {
                group.addTask {
                    let fullInfoArtist = await self.getArtist(artistID: artID.id)
                    return fullInfoArtist
                }
            }
            
            for await artist in group {
                if let artist = artist {
                    fullInfoArtits.append(artist)
                }
                
            }
        })
        
        return fullInfoArtits
    }

}

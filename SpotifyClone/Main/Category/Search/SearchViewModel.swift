//
//  SearchViewModel.swift
//  SpotifyClone
//
//  Created by Павел Кай on 12.03.2023.
//

import UIKit

class SearchViewModel {
    
    lazy var searchAlbums = [Album]()
    lazy var searchArtists = [Artist]()
    lazy var searchTracks = [Track]()
    lazy var allResults: [Any] = []
    var color: UIColor?
    
    
    func getSearchResults(query: String, type: String) async {
        do {
            let result = try await APIManager().getSpotifyContent(type: SearchResponse.self, endpoint: SearchEndpoint.search(query: query, type: type))
            allResults = []
            searchAlbums = result.albums.items
            searchArtists = result.artists.items
            searchTracks = result.tracks.items
            allResults.append(contentsOf: searchAlbums)
            allResults.append(contentsOf: searchArtists)
            allResults.append(contentsOf: searchTracks)
            await getColorFromFetchedImage()
        } catch {
            print(error)
        }
    }
    
    func getColorFromFetchedImage() async {
        if let artist = allResults.first as? Artist, let imageUrl = artist.images?.first?.url {
            let result = try? await fetchImage(from: imageUrl)
            color = result?.averageColor ?? .systemGray5
        } else if let album = allResults.first as? Album, let imageUrl = album.images?.first?.url {
            let result = try? await fetchImage(from: imageUrl)
            color = result?.averageColor ?? .systemGray5
        } else if let track = allResults.first as? Track, let imageUrl = track.album?.images?.first?.url {
            let result = try? await fetchImage(from: imageUrl)
            color = result?.averageColor ?? .systemGray5
        } else {
            color = .systemGray6
        }
    }
    
    func fetchImage(from url: String) async throws -> UIImage {
        guard let url = URL(string: url) else { throw NSError(domain: "BadUrl", code: 0)}
        let (data, _) = try await URLSession.shared.data(from: url)
        guard let image = UIImage(data: data) else { throw NSError(domain: "DownloadError", code: 0) }
        return image
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

//
//  AlbumDetailViewModel.swift
//  SpotifyClone
//
//  Created by Павел Кай on 28.01.2023.
//

import Foundation

final class PlaylistAlbumDetailViewModel {
    
    var tracks = [Track]()
    var playlist: PlaylistItem?
    var album: Album?
    
    var artist: Artist?
    var user: User?
    
    func convertSecondsToHrMinute(miliseconds: Int) -> String {
        var calendar = Calendar.current
        calendar.locale = .init(identifier: "en")
        
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute]
        formatter.unitsStyle = .short
        formatter.calendar = calendar
        
        let seconds = miliseconds / 1000
        
        let formattedString = formatter.string(from:TimeInterval(seconds))!
        return formattedString
    }
 
}

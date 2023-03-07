//
//  Notification+Name.swift
//  SpotifyClone
//
//  Created by Павел Кай on 07.03.2023.
//

import Foundation

extension Notification.Name {
    
    static let didStartPlayingNewTrack = Notification.Name("didStartPlayingNewTrack")
    
    static let didPauseTrack = Notification.Name("didPauseTrack")
    
}

extension Notification {
    
    static let key = "key"
    
}

//
//  PlayerViewViewModel.swift
//  SpotifyClone
//
//  Created by Павел Кай on 03.02.2023.
//

import Foundation

final class PlayerViewViewModel {
    
    var track: Track?
    
    var didTapPreviousSong = false
    var didTapPauseSong = false
    var didTapNextSong = false
    
    func getFormattedTime(timeInterval: TimeInterval) -> String {
        let mins = timeInterval / 60
        let secs = timeInterval.truncatingRemainder(dividingBy: 60)
        let timeformatter = NumberFormatter()
        timeformatter.minimumIntegerDigits = 2
        timeformatter.minimumFractionDigits = 0
        timeformatter.roundingMode = .down
        guard let minsStr = timeformatter.string(from: NSNumber(value: mins)), let secsStr = timeformatter.string(from: NSNumber(value: secs)) else {
            return ""
        }
        return "\(minsStr):\(secsStr)"
    }
    
    func pauseSong() {
        
    }
    
    func nextSong() {
        
    }
    
    func previousSong() {
        
    }
    
    func getTrack(with trackID: String) async {
        do {
            let result = try await APIManager().getSpotifyContent(type: Track.self, endpoint: ContentEndpoint.getTrack(trackID: trackID))
            track = result
        } catch {
            print(error)
        }
    }
    
}

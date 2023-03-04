//
//  PlayerViewModel.swift
//  SpotifyClone
//
//  Created by Павел Кай on 03.02.2023.
//

import Foundation
import AVFoundation

protocol PlayerViewViewModelDelegate {
    func didStartPlayTrack(_ duration: TimeInterval)
    func updateWhilePlaying(_ timeElapsed: String, _ timeLeft: String, _ timeElapsedSlider: Float)
    
    func isPlayingTrack(_ isPlaying: Bool)
    
    func didActivateShufflePlay(_ isShufflePlayEnabled: Bool)
    func didActivateRepeat(_ isRepeatEnabled: Bool)
    
    func didFinishSong(_ didFinishSong: Bool)
}

final class PlayerViewModel: NSObject {
    
    private var player = AVAudioPlayer()
    
    private var isPlaying = false {
        didSet {
            delegate?.isPlayingTrack(isPlaying)
        }
    }
    
    var currentTrackIndex = 0
    
    var isShuffleEnabled = false {
        didSet {
            delegate?.didActivateShufflePlay(isShuffleEnabled)
        }
    }
    
    var isRepeatEnabled = false {
        didSet {
            delegate?.didActivateRepeat(isRepeatEnabled)
        }
    }
    
    var didFinishSong = false {
        didSet {
            delegate?.didFinishSong(didFinishSong)
        }
    }
    
    var tracksID = [String]()
    var shuffleTracksID = [String]()
    var track: Track?
    
    var delegate: PlayerViewViewModelDelegate?
    
    private var timer: CADisplayLink?

    override init() {
        super.init()
        timer = CADisplayLink(target: self, selector: #selector(updateWhilePlaying))
        timer?.add(to: .current, forMode: .default)
    }
    
    @objc func updateWhilePlaying() {
        let timeElapsed = getFormattedTime(timeInterval: player.currentTime)
        let timeLeft = getFormattedTime(timeInterval: player.duration)
        let timeElapsedSlider = Float(player.currentTime)
        delegate?.updateWhilePlaying(timeElapsed, timeLeft, timeElapsedSlider)
    }
    
    func getNextSong() -> String {
        if isShuffleEnabled {
            
            currentTrackIndex += 1
            
            if currentTrackIndex > shuffleTracksID.count - 1 {
                currentTrackIndex = 0
            }
            return shuffleTracksID[currentTrackIndex]
        }
        
        currentTrackIndex += 1
        
        if currentTrackIndex > tracksID.count - 1 {
            currentTrackIndex = 0
        }

        isRepeatEnabled = false
        let nextTrack = tracksID[currentTrackIndex]
        return nextTrack
    }
    
    func resetTrackTweaks() {
        isShuffleEnabled = false
        isRepeatEnabled = false
    }
    
    func getPrevoiusSong() -> String {
        if isShuffleEnabled {
            
            currentTrackIndex -= 1
            
            if currentTrackIndex < 0 {
                currentTrackIndex = shuffleTracksID.count - 1
            }
            return shuffleTracksID[currentTrackIndex]
        }
        
        currentTrackIndex -= 1
        
        if currentTrackIndex < 0 {
            currentTrackIndex = tracksID.count - 1
        }
        
        isRepeatEnabled = false
        let previousTrack = tracksID[currentTrackIndex]
        return previousTrack
    }
    
    func activateShufflePlay() {
        isShuffleEnabled.toggle()
        if isShuffleEnabled {
            shuffleTracksID.shuffle()
            currentTrackIndex = shuffleTracksID.firstIndex(of: track?.id ?? "") ?? 0
        } else {
            currentTrackIndex = tracksID.firstIndex(of: track?.id ?? "") ?? 0
            print(currentTrackIndex)
        }
    }
    
    func activateRepeat() {
        if isRepeatEnabled {
            player.numberOfLoops = 0
        } else {
            player.numberOfLoops = -1
        }
        isRepeatEnabled.toggle()
    }
    
    func didTapPause() {
        if isPlaying {
            player.stop()
        } else {
            player.play()
        }
        isPlaying.toggle()
    }
    
    func didSlide(by value: Double) {
        player.currentTime = value
    }
    
    private func getFormattedTime(timeInterval: TimeInterval) -> String {
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
    
    func getTrack(with trackID: String) async {
        do {
            let result = try await APIManager().getSpotifyContent(type: Track.self, endpoint: ContentEndpoint.getTrack(trackID: trackID))
            track = result
        } catch {
            print(error)
        }
    }
    
    func playTrack(url: String) {
        guard let url = URL(string: url) else { return }
        
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            if let data = try? Data(contentsOf: url) {
                DispatchQueue.main.async {
                    do {
                        self.player = try AVAudioPlayer(data: data)
                        self.player.delegate = self
                        self.player.volume = 0.1
                        self.player.play()
                        self.isPlaying = true
                        self.didFinishSong = false
                        self.delegate?.didStartPlayTrack(self.player.duration)
                    } catch {
                        print(error.localizedDescription)
                    }
                }
                
            }
        }
    }
    
}

extension PlayerViewModel {
    
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
    
}

extension PlayerViewModel: AVAudioPlayerDelegate {
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        didFinishSong = true
    }
    
}

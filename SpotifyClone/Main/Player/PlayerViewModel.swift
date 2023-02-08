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
}

final class PlayerViewModel {
    
    private var player = AVAudioPlayer()
    
    private var isPlaying = false
    
    var track: Track?
    
    var delegate: PlayerViewViewModelDelegate?
    
    private var timer: CADisplayLink?

    init() {
        timer = CADisplayLink(target: self, selector: #selector(updateWhilePlaying))
        timer?.add(to: .current, forMode: .default)
    }
    
    @objc func updateWhilePlaying() {
        let remainingTimeInSeconds = player.duration - player.currentTime
        let timeElapsed = getFormattedTime(timeInterval: player.currentTime)
        let timeLeft = getFormattedTime(timeInterval: remainingTimeInSeconds)
        let timeElapsedSlider = Float(player.currentTime)
        delegate?.updateWhilePlaying(timeElapsed, timeLeft, timeElapsedSlider)
    }
    
    func didTapPause() {
        if isPlaying {
            player.stop()
        } else {
            player.play()
        }
        isPlaying.toggle()
        delegate?.isPlayingTrack(isPlaying)
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
                        self.player.volume = 0.3
                        self.player.play()
                        self.isPlaying = true
                        self.delegate?.didStartPlayTrack(self.player.duration)
                    } catch {
                        print(error.localizedDescription)
                    }
                }
                
            }
        }
    }
    
}

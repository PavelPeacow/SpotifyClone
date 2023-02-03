//
//  PlayerViewController.swift
//  SpotifyClone
//
//  Created by Павел Кай on 03.02.2023.
//

import UIKit
import AVFoundation

final class PlayerViewController: UIViewController {
    
    static let shared = PlayerViewController()
    
    private let playerView = PlayerView()
    private let viewModel = PlayerViewViewModel()
    
    private var player: AVAudioPlayer?
    
    var isPlaying = true
    var timer: CADisplayLink?
    
    override func loadView() {
        super.loadView()
        view = playerView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timer = CADisplayLink(target: self, selector: #selector(updateWhilePlaying))
        timer?.add(to: .current, forMode: .default)
        addTargets()
    }
    
    private func addTargets() {
        playerView.timeElapsedSlider.addTarget(self, action: #selector(didSlideSlider(_:)), for: .valueChanged)
        playerView.leftControlBtn.addTarget(self, action: #selector(didTapPrevousSongBtn), for: .touchUpInside)
        playerView.pauseControlBtn.addTarget(self, action: #selector(didTapPauseBtn), for: .touchUpInside)
        playerView.rightControlBtn.addTarget(self, action: #selector(didTapNextSongBtn), for: .touchUpInside)
    }
    
    func startPlaySong(song: String) {
        Task { [weak self] in
            await viewModel.getTrack(with: song)
            isPlaying = true
            guard let url = URL(string: viewModel.track?.album?.images?.first?.url ?? "") else { return }
            
            playerView.cover.loadImage(for: url)
            playerView.songTitle.text = viewModel.track?.name
            playerView.groupTitle.text = viewModel.track?.artists?.first?.name
            
            guard let url = URL(string: viewModel.track?.previewURL ?? "") else { return }

            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        do {
                            self?.player = try AVAudioPlayer(data: data)
                            self?.player?.volume = 0.1
                            self?.player?.play()
                            self?.playerView.timeElapsedSlider.maximumValue = Float(self?.player?.duration ?? 0.0)
                        } catch {
                            print(error.localizedDescription)
                        }
                    }
                    
                }
            }
            
            
        }
        
    }

}

extension PlayerViewController {
    
    @objc func updateWhilePlaying() {
        let remainingTimeInSeconds = player?.duration ?? 0.0 - (player?.currentTime ?? 0.0)
        playerView.timeElapsed.text = viewModel.getFormattedTime(timeInterval: player?.currentTime ?? 0.0)
        playerView.timeLeft.text = viewModel.getFormattedTime(timeInterval: remainingTimeInSeconds)
        playerView.timeElapsedSlider.value = Float(self.player?.currentTime ?? 0.0)
    }
    
    @objc func didSlideSlider(_ sender: UISlider) {
        let value = sender.value
        player?.currentTime = Float64(value)
    }
    
    @objc func didTapPrevousSongBtn() {
        
    }
    
    @objc func didTapPauseBtn() {
        if isPlaying {
            player?.stop()
            playerView.pauseControlBtn.setSFImage(systemName: "play.circle.fill", size: 50, color: .white)
        } else {
            player?.play()
            playerView.pauseControlBtn.setSFImage(systemName: "pause.circle.fill", size: 50, color: .white)
        }
        isPlaying.toggle()
    }
    
    @objc func didTapNextSongBtn() {
        
    }
    
}

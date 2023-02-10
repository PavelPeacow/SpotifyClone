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
    private var viewModel = PlayerViewModel()
    
    private lazy var tabbar = presentingViewController as? MainTabBarViewController
    
    override func loadView() {
        super.loadView()
        view = playerView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addTargets()
        setDelegates()
    }
    
    override func viewDidLayoutSubviews() {
        playerView.gradient.frame = playerView.bounds
    }
    
    private func setDelegates() {
        viewModel.delegate = self
    }
    
    private func addTargets() {
        playerView.timeElapsedSlider.addTarget(self, action: #selector(didSlideSlider(_:)), for: .valueChanged)
        playerView.leftControlBtn.addTarget(self, action: #selector(didTapPrevousSongBtn), for: .touchUpInside)
        playerView.pauseControlBtn.addTarget(self, action: #selector(didTapPauseBtn), for: .touchUpInside)
        playerView.rightControlBtn.addTarget(self, action: #selector(didTapNextSongBtn), for: .touchUpInside)
    }
    
    func startPlaySongs(songs: [String], at posititon: Int) {
        viewModel.tracksID = songs
        viewModel.currentTrackIndex = posititon
        startPlaySong(song: songs[posititon])
    }
    
    func startPlaySong(song: String) {
        Task { [weak self] in
            await viewModel.getTrack(with: song)
            guard let url = URL(string: viewModel.track?.album?.images?.first?.url ?? "") else { return }
            
            playerView.cover.loadImage(for: url) { [weak self] in
                let averageColor = self?.playerView.cover.image?.averageColor ?? .green
                self?.playerView.gradient.colors = [
                    averageColor.cgColor,
                    UIColor.black.cgColor
                ]
            }
            playerView.songTitle.text = viewModel.track?.name
            playerView.groupTitle.text = viewModel.track?.artists?.first?.name
            
            
            tabbar?.playerViewBottom.configure(imageURL: viewModel.track?.album?.images?.first?.url ?? "", songTitle: viewModel.track?.name ?? "", groupTitle: viewModel.track?.artists?.first?.name ?? "")
            
            viewModel.playTrack(url: viewModel.track?.previewURL ?? "")
        }
        
    }
    
    func pauseFromBottomPlayerView() {
        viewModel.didTapPause()
    }
    
}

extension PlayerViewController: PlayerViewViewModelDelegate {

    func didStartPlayTrack(_ duration: TimeInterval) {
        playerView.timeElapsedSlider.maximumValue = Float(duration)
    }
    
    func updateWhilePlaying(_ timeElapsed: String, _ timeLeft: String, _ timeElapsedSlider: Float) {
        playerView.timeElapsed.text = timeElapsed
        playerView.timeLeft.text = timeLeft
        playerView.timeElapsedSlider.value = timeElapsedSlider
    }
    
    func isPlayingTrack(_ isPlaying: Bool) {
        if isPlaying {
            playerView.pauseControlBtn.setSFImage(systemName: "pause.circle.fill", size: 50, color: .white)
            tabbar?.playerViewBottom.playBtn.setSFImage(systemName: "pause.circle.fill", size: 20, color: .white)
        } else {
            playerView.pauseControlBtn.setSFImage(systemName: "play.circle.fill", size: 50, color: .white)
            tabbar?.playerViewBottom.playBtn.setSFImage(systemName: "play.circle.fill", size: 20, color: .white)
        }
    }
}

extension PlayerViewController {

    @objc func didSlideSlider(_ sender: UISlider) {
        let value = Double(sender.value)
        viewModel.didSlide(by: value)
    }
    
    @objc func didTapPrevousSongBtn() {
        let previousSong = viewModel.getPrevoiusSong()
        startPlaySong(song: previousSong)
    }
    
    @objc func didTapPauseBtn() {
        viewModel.didTapPause()
    }
    
    @objc func didTapNextSongBtn() {
        let nextSong = viewModel.getNextSong()
        startPlaySong(song: nextSong)
    }
    
}

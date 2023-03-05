//
//  PlaylistAlbumHeaderCollectionReusableView.swift
//  SpotifyClone
//
//  Created by Павел Кай on 31.01.2023.
//

import UIKit

protocol PlaylistAlbumHeaderCollectionReusableViewDelegate {
    func didTapArtist()
    func didTapPlayBtn(_ isTap: Bool)
}

class PlaylistAlbumHeaderCollectionReusableView: UICollectionReusableView {
    
    static let identifier = "PlaylistAlbumHeaderCollectionReusableView"
    
    var delegate: PlaylistAlbumHeaderCollectionReusableViewDelegate?
    
    var isTapPlayBtn = false {
        willSet {
            if newValue {
                playBtn.setSFImage(systemName: "pause.circle", size: 54, color: .green)
            } else {
                playBtn.setSFImage(systemName: "play.circle", size: 54, color: .green)
            }
        }
    }
    var id: String?
    
    private lazy var stackViewDescription: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [title, stackViewArtist, typeAndDate])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        stackView.spacing = 10
        stackView.alignment = .fill
        stackView.axis = .vertical
        return stackView
    }()
    
    private lazy var title: UILabel = {
        let label = UILabel()
        label.font = .setFont(.bold, size: 22)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 2
        label.isUserInteractionEnabled = true
        return label
    }()
    
    private lazy var stackViewArtist: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [artistImage, artistTitle])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        stackView.spacing = 10
        stackView.alignment = .fill
        stackView.axis = .horizontal
        stackView.isUserInteractionEnabled = true
        return stackView
    }()
    
    private lazy var artistImage: UIImageViewURL = {
        let image = UIImageViewURL()
        image.contentMode = .scaleAspectFit
        image.isUserInteractionEnabled = true
        image.clipsToBounds = true
        return image
    }()
    
    private lazy var artistTitle: UILabel = {
        let label = UILabel()
        label.font = .setFont(.bold, size: 16)
        label.adjustsFontSizeToFitWidth = true
        label.isUserInteractionEnabled = true
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var typeAndDate: UILabel = {
        let label = UILabel()
        label.font = .setFont(.book, size: 16)
        label.textColor = .secondaryLabel
        return label
    }()
    
    private lazy var playBtn: UIButton = {
        let btn = UIButton()
        btn.setSFImage(systemName: "play.circle", size: 54, color: .green)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(stackViewDescription)
        addSubview(playBtn)
        
        PlayerViewController.shared.delegate = self
        
        addGestures()
        addTargets()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addGestures() {
        let tapArtist = UITapGestureRecognizer(target: self, action: #selector(didTapArtist))
        artistImage.addGestureRecognizer(tapArtist)
        artistTitle.addGestureRecognizer(tapArtist)
    }
    
    private func addTargets() {
        playBtn.addTarget(self, action: #selector(didTapPlayBtn), for: .touchUpInside)
    }
    
    func isPlayingThisAlbum() {
        if !PlayerViewController.shared.viewModel.isPlaying {
            isTapPlayBtn = false
            return
        }
        
        if PlayerViewController.shared.viewModel.track?.album?.id ?? "" == id && PlayerViewController.shared.viewModel.playlistIdOfPlayingTrack == nil || PlayerViewController.shared.viewModel.playlistIdOfPlayingTrack == id {
            isTapPlayBtn = true
            print("churka")
        } else {
            isTapPlayBtn = false
        }
    }
    
    func didStartPlayTappedSong() {
        isTapPlayBtn = true
    }
    
    func setCover(title: String, typeAndDate: String?, artistImage: String, artistTitle: String) {
        self.title.text = title
        self.typeAndDate.text = typeAndDate
        self.artistTitle.text = artistTitle
        print(artistImage)
        
        guard let url = URL(string: artistImage) else { return }
        
        self.artistImage.loadImage(for: url)
        layoutIfNeeded()
        self.artistImage.layer.cornerRadius = self.artistImage.frame.height / 2
    }
    
}

extension PlaylistAlbumHeaderCollectionReusableView: PlayerViewControllerDelegate {
    
    func didTapPause(_ isPlaying: Bool) {
        if isPlaying && PlayerViewController.shared.viewModel.track?.album?.id ?? "" == id && PlayerViewController.shared.viewModel.playlistIdOfPlayingTrack == nil || PlayerViewController.shared.viewModel.playlistIdOfPlayingTrack == id {
            isTapPlayBtn = true
        } else {
            isTapPlayBtn = false
        }
    }
    
}

extension PlaylistAlbumHeaderCollectionReusableView {
    
    @objc func didTapArtist() {
        delegate?.didTapArtist()
    }
    
    @objc func didTapPlayBtn() {
        isTapPlayBtn.toggle()
        delegate?.didTapPlayBtn(isTapPlayBtn)
    }
    
}

extension PlaylistAlbumHeaderCollectionReusableView {
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            stackViewDescription.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
            stackViewDescription.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            stackViewDescription.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            
            artistImage.heightAnchor.constraint(equalToConstant: 40),
            artistImage.widthAnchor.constraint(equalToConstant: 40),
            
            playBtn.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            playBtn.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            playBtn.heightAnchor.constraint(equalToConstant: 54),
            playBtn.widthAnchor.constraint(equalToConstant: 54),
        ])
    }
}

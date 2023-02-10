//
//  PlayerViewBottom.swift
//  SpotifyClone
//
//  Created by Павел Кай on 10.02.2023.
//

import UIKit

final class PlayerViewBottom: UIView {
    
    lazy var cover: UIImageViewURL = {
        let image = UIImageViewURL()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 5
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy var title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    lazy var playBtn: UIButton = {
        let button = UIButton()
        button.setSFImage(systemName: "pause.circle.fill", size: 20, color: .white)
        button.addTarget(self, action: #selector(didTapPlayBtn), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(cover)
        addSubview(title)
        addSubview(playBtn)

        setUpView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpView() {
        isHidden = true
        backgroundColor = .red
        clipsToBounds = true
        layer.cornerRadius = 5
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configure(imageURL: String, songTitle: String, groupTitle: String) {
        guard let url = URL(string: imageURL) else { return }
        isHidden = false
        cover.loadImage(for: url) { [weak self] in
            let averageColor = self?.cover.image?.averageColor ?? .green
            self?.backgroundColor = averageColor
        }
        
        title.text = "\(songTitle)*\(groupTitle)"
    }
    
}

extension PlayerViewBottom {
    
    @objc func didTapPlayBtn() {
        PlayerViewController.shared.pauseFromBottomPlayerView()
    }
    
}

extension PlayerViewBottom {
    
    func setConstraints() {
        NSLayoutConstraint.activate([            
            cover.heightAnchor.constraint(equalToConstant: 40),
            cover.widthAnchor.constraint(equalToConstant: 40),
            cover.centerYAnchor.constraint(equalTo: centerYAnchor),
            cover.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            
            title.centerYAnchor.constraint(equalTo: centerYAnchor),
            title.trailingAnchor.constraint(equalTo: playBtn.leadingAnchor, constant: -5),
            title.leadingAnchor.constraint(equalTo: cover.trailingAnchor, constant: 5),
            
            playBtn.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            playBtn.centerYAnchor.constraint(equalTo: centerYAnchor),
            playBtn.heightAnchor.constraint(equalToConstant: 20),
            playBtn.widthAnchor.constraint(equalToConstant: 20),
        ])
    }
}

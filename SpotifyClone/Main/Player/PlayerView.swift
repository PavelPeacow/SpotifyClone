//
//  PlayerView.swift
//  SpotifyClone
//
//  Created by Павел Кай on 03.02.2023.
//

import UIKit

final class PlayerView: UIView {
    
    lazy var cover: UIImageViewURL = {
        let image = UIImageViewURL()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var songTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.text = "Hereafter"
        return label
    }()
    
    lazy var groupTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        label.text = "Architects"
        return label
    }()
    
    lazy var timeElapsedSlider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.tintColor = .white
        return slider
    }()
    
    lazy var timeElapsed: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "4:02"
        return label
    }()
    
    lazy var timeLeft: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "4:02"
        return label
    }()
    
    lazy var controlsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [leftControlBtn, pauseControlBtn, rightControlBtn])
        stackView.alignment = .center
        stackView.spacing = 15
        stackView.distribution = .fill
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var leftControlBtn: UIButton = {
        let button = UIButton()
        button.setSFImage(systemName: "arrow.left.to.line.circle.fill", size: 50, color: .white)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var pauseControlBtn: UIButton = {
        let button = UIButton()
        button.setSFImage(systemName: "pause.circle.fill", size: 50, color: .white)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var rightControlBtn: UIButton = {
        let button = UIButton()
        button.setSFImage(systemName: "arrow.right.to.line.circle.fill", size: 50, color: .white)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    init() {
        super.init(frame: .zero)
        
        backgroundColor = .black
        
        addSubview(cover)
        addSubview(songTitle)
        addSubview(groupTitle)
        
        addSubview(timeElapsedSlider)
        addSubview(timeElapsed)
        addSubview(timeLeft)
        
        addSubview(controlsStackView)
        
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PlayerView {
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            cover.centerXAnchor.constraint(equalTo: centerXAnchor),
            cover.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 25),
            cover.heightAnchor.constraint(equalToConstant: 300),
            cover.widthAnchor.constraint(equalToConstant: 300),
            
            songTitle.topAnchor.constraint(equalTo: cover.bottomAnchor, constant: 20),
            songTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            
            groupTitle.topAnchor.constraint(equalTo: songTitle.bottomAnchor),
            groupTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            
            timeElapsedSlider.topAnchor.constraint(equalTo: groupTitle.bottomAnchor, constant: 20),
            timeElapsedSlider.centerXAnchor.constraint(equalTo: centerXAnchor),
            timeElapsedSlider.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            timeElapsedSlider.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            
            timeElapsed.topAnchor.constraint(equalTo: timeElapsedSlider.bottomAnchor),
            timeElapsed.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            
            timeLeft.topAnchor.constraint(equalTo: timeElapsedSlider.bottomAnchor),
            timeLeft.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            
            controlsStackView.topAnchor.constraint(equalTo: timeElapsedSlider.bottomAnchor, constant: 20),
            controlsStackView.centerXAnchor.constraint(equalTo: timeElapsedSlider.centerXAnchor),
        ])
    }
}

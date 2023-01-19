//
//  LoginView.swift
//  SpotifyClone
//
//  Created by Павел Кай on 19.01.2023.
//

import UIKit

final class LoginView: UIView {
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [logoImage, loginTitle, loginBtn])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.spacing = 15
        return stackView
    }()
    
    lazy var logoImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "music.note.house.fill")?.withTintColor(.green, renderingMode: .alwaysOriginal)
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var loginTitle: UILabel = {
        let label = UILabel()
        label.text = "Millions of songs.\nFree on spotify."
        label.numberOfLines = 2
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var loginBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Log in", for: .normal)
        btn.backgroundColor = .green
        btn.layer.cornerRadius = 15
        btn.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        btn.setTitleColor(.label, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    init() {
        super.init(frame: .zero)
        addSubview(stackView)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LoginView {
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            stackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -25),
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            
            logoImage.heightAnchor.constraint(equalToConstant: 100),
            logoImage.widthAnchor.constraint(equalToConstant: 100),
            
            loginBtn.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.8)
        ])
    }
    
}

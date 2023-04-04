//
//  LibraryFilterCollectionReusableView.swift
//  SpotifyClone
//
//  Created by Павел Кай on 04.04.2023.
//

import UIKit

class LibraryFilterCollectionReusableView: UICollectionReusableView {
        
    static let identifier = "LibraryFilterCollectionReusableView"
    
    lazy var filterStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [libraryFilterBtn, libraryFilterTitle])
        stackView.distribution = .fill
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.spacing = 6
        stackView.translatesAutoresizingMaskIntoConstraints = false
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapFilteBtn))
        stackView.addGestureRecognizer(gesture)
        return stackView
    }()
    
    lazy var libraryFilterBtn: UIButton = {
        let btn = UIButton()
        btn.setSFImage(systemName: "arrow.up.arrow.down", size: 15, color: .white)
        btn.isUserInteractionEnabled = false
        return btn
    }()
    
    lazy var libraryFilterTitle: UILabel = {
        let label = UILabel()
        label.text = "Recents"
        label.font = .setFont(.light, size: 15)
        return label
    }()
    
    lazy var libraryStyleBtn: UIButton = {
        let btn = UIButton()
        btn.setSFImage(systemName: "square.grid.2x2", size: 15, color: .white)
        btn.addTarget(self, action: #selector(didTapLibraryStyleBtn), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(filterStackView)
        addSubview(libraryStyleBtn)
        
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension LibraryFilterCollectionReusableView {
    
    @objc func didTapFilteBtn() {
        print("tap filter")
    }
    
    @objc func didTapLibraryStyleBtn() {
        print("tap style")
    }
    
}

extension LibraryFilterCollectionReusableView {
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            filterStackView.topAnchor.constraint(equalTo: topAnchor),
            filterStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            libraryStyleBtn.trailingAnchor.constraint(equalTo: trailingAnchor),
            libraryStyleBtn.topAnchor.constraint(equalTo: topAnchor),
            libraryStyleBtn.heightAnchor.constraint(equalToConstant: 20),
            libraryStyleBtn.widthAnchor.constraint(equalToConstant: 20),
        ])
    }
    
}

//
//  HeaderCollectionReusableView.swift
//  SpotifyClone
//
//  Created by Павел Кай on 27.01.2023.
//

import UIKit

final class HeaderCollectionReusableView: UICollectionReusableView {
        
    static let identifier = "HeaderCollectionReusableView"
    
    private lazy var sectionTitle: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(sectionTitle)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        sectionTitle.frame = bounds
    }
    
    func setTitle(with title: String) {
        sectionTitle.text = title
    }
    
}

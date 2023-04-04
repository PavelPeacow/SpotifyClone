//
//  LibraryTopView.swift
//  SpotifyClone
//
//  Created by Павел Кай on 02.04.2023.
//

import UIKit

class LibraryTopView: UIView {
        
    static let identifier = "LibraryHeaderCollectionReusableView"
    
    let categories = ["Playlists", "Albums", "Artists"]
    
    lazy var contentStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [profileStackView, btnsStackView])
        stackView.distribution = .equalCentering
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.spacing = 6
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var profileStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [profileImage, libraryTitle])
        stackView.distribution = .fill
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.spacing = 6
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var profileImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.layer.cornerRadius = 15
        image.backgroundColor = .brown
        return image
    }()
    
    lazy var libraryTitle: UILabel = {
        let label = UILabel()
        label.text = "Your Library"
        label.font = .setFont(.bold, size: 24)
        return label
    }()
    
    lazy var btnsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [searchBtn, addBtn])
        stackView.distribution = .fillProportionally
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.spacing = 12
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var searchBtn: UIButton = {
        let btn = UIButton()
        btn.addTarget(self, action: #selector(didTapSearchBtn), for: .touchUpInside)
        btn.setSFImage(systemName: "magnifyingglass", size: 20, color: .white)
        return btn
    }()
    
    lazy var addBtn: UIButton = {
        let btn = UIButton()
        btn.addTarget(self, action: #selector(didTapAddBtn), for: .touchUpInside)
        btn.setSFImage(systemName: "plus", size: 20, color: .white)
        return btn
    }()
    
    lazy var categoryFilterStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [cancelBtn])
        stackView.distribution = .fill
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.spacing = 12
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var cancelBtn: UIButton = {
        let btn = UIButton()
        btn.setSFImage(systemName: "xmark", size: 20, color: .white)
        btn.backgroundColor = .systemGray6
        btn.layer.cornerRadius = 20
        btn.isHidden = true
        btn.addTarget(self, action: #selector(didTapCancenBtn), for: .touchUpInside)
        return btn
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(contentStackView)
        addSubview(categoryFilterStackView)
        
        backgroundColor = .mainBackground
        
        createCategoriesFilter()
        
        addBottomShadow()
        
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createCategoriesFilter() {
        for categoryTitle in categories {
            let categoryView = CategoryLibraryView()
            categoryView.configure(title: categoryTitle)
            
            let gesutre = UITapGestureRecognizer(target: self, action: #selector(didSelectCategory))
            categoryView.addGestureRecognizer(gesutre)
            
            NSLayoutConstraint.activate([
                categoryView.heightAnchor.constraint(equalToConstant: 40),
            ])
            
            categoryFilterStackView.addArrangedSubview(categoryView)
            
        }
    }
    
    func configure() {
        
    }
    
}

extension LibraryTopView {
    
    @objc func didSelectCategory(_ sender: UITapGestureRecognizer) {
       
        guard let categoryView = sender.view as? CategoryLibraryView else { return }
        print("tapCategory")
        
        if categoryView.isSelected == true {
            categoryView.isSelected = false
            cancelBtn.isHidden = true
            
            categoryFilterStackView.arrangedSubviews.forEach {
                guard let stackViewCategorySubView = $0 as? CategoryLibraryView else { return }
                if stackViewCategorySubView.isSelected != true {
                    $0.isHidden = false
                }
            }
            
        } else {
            categoryView.isSelected = true
            cancelBtn.isHidden = false
            
            categoryFilterStackView.arrangedSubviews.forEach {
                guard let stackViewCategorySubView = $0 as? CategoryLibraryView else { return }
                if stackViewCategorySubView.isSelected != true {
                    $0.isHidden = true
                }
            }
        }
        
        
        UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 0.9,
                       initialSpringVelocity: 1, options: .transitionCrossDissolve) { [weak self] in
            self?.layoutIfNeeded()
        }
        
    }
    
    @objc func didTapCancenBtn() {
        cancelBtn.isHidden = true
        
        categoryFilterStackView.arrangedSubviews.forEach {
            guard let stackViewCategorySubView = $0 as? CategoryLibraryView else { return }
            if stackViewCategorySubView.isSelected != true {
                $0.isHidden = false
            }
            
            if stackViewCategorySubView.isSelected == true {
                stackViewCategorySubView.isSelected = false
            }
        }
        
        UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 0.9,
                       initialSpringVelocity: 1, options: .transitionCrossDissolve) { [weak self] in
            self?.layoutIfNeeded()
        }
    }
    
    @objc func didTapSearchBtn() {
        print("tapSearch")
    }
    
    @objc func didTapAddBtn() {
        print("tapAdd")
    }
    
}

extension LibraryTopView {
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 15),
            contentStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            contentStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            
            categoryFilterStackView.topAnchor.constraint(equalTo: contentStackView.bottomAnchor, constant: 16),
            categoryFilterStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            
            profileImage.heightAnchor.constraint(equalToConstant: 30),
            profileImage.widthAnchor.constraint(equalToConstant: 30),
            
            addBtn.heightAnchor.constraint(equalToConstant: 30),
            addBtn.widthAnchor.constraint(equalToConstant: 30),
            
            searchBtn.heightAnchor.constraint(equalToConstant: 30),
            searchBtn.widthAnchor.constraint(equalToConstant: 30),
            
            cancelBtn.heightAnchor.constraint(equalToConstant: 40),
            cancelBtn.widthAnchor.constraint(equalToConstant: 40),
        ])
    }
    
}

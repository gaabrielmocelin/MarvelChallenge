//
//  CharacterCell.swift
//  MarvelChallenge
//
//  Created by Gabriel Mocelin on 02/03/20.
//  Copyright © 2020 Gabriel Mocelin. All rights reserved.
//

import UIKit

final class CharacterCell: UICollectionViewCell {
    
    let imageView = UIImageView()
    let separatorView = UIView()
    let nameLabel = UILabel(fontSize: 16, weight: .semibold)
    
   override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewConfiguration()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(with char: Character, imageService: CharactersServiceProtocol) {
        nameLabel.text = char.name
        
        //set placeholder
        imageService.fetchImage(imageURL: char.imageUrl, with: .portraitLarge) { [weak self] (result) in
            switch result {
            case .success(let image):
                self?.imageView.image = image
            case .failure(_):
                break
            }
        }
    }
}

extension CharacterCell: ViewConfigurator {
    func buildViewHierarchy() {
        addSubview(imageView)
        addSubview(separatorView)
        addSubview(nameLabel)
    }
    
    func setupConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.7).isActive = true
        
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        separatorView.topAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
        separatorView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        separatorView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        separatorView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.05).isActive = true
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.topAnchor.constraint(equalTo: separatorView.bottomAnchor).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        nameLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.25).isActive = true
    }
    
    func configureViews() {
        backgroundColor = .marvelBlack
        layer.cornerRadius = 10
        clipsToBounds = true
        
        nameLabel.textColor = .white
        separatorView.backgroundColor = .marvelRed
        
        nameLabel.numberOfLines = 0
        nameLabel.textAlignment = .center
    }
}

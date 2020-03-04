//
//  ComicCell.swift
//  MarvelChallenge
//
//  Created by Gabriel Mocelin on 03/03/20.
//  Copyright © 2020 Gabriel Mocelin. All rights reserved.
//

import UIKit

final class ComicCell: UITableViewCell {
    var comic: Comic?
    
    let comicImageView = UIImageView()
    let titleLabel = UILabel(fontSize: 14, weight: .regular)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViewConfiguration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        comicImageView.image = nil
    }
    
    func setup(with comic: Comic, imageService: ImageServiceProtocol) {
        self.comic = comic
        titleLabel.text = comic.title
        
        imageService.fetchImage(imageURL: comic.imageUrl, with: .portraitMedium) { (result) in
            switch result {
            case .success(let image):
                //validate if the donwloaded image stills matchs the comic, because cell may be reused.
                if self.comic?.id == comic.id {
                    self.comicImageView.image = image
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension ComicCell: ViewConfigurator {
    func buildViewHierarchy() {
        addSubview(comicImageView)
        addSubview(titleLabel)
    }
    
    func setupConstraints() {
        comicImageView.translatesAutoresizingMaskIntoConstraints = false
        comicImageView.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        comicImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        comicImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20).isActive = true
        comicImageView.heightAnchor.constraint(equalToConstant: 170).isActive = true
        comicImageView.widthAnchor.constraint(equalToConstant: 120).isActive = true
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: comicImageView.trailingAnchor, constant: 15).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20).isActive = true
    }
    
    func configureViews() {
        selectionStyle = .none
        backgroundColor = .clear
        
        titleLabel.numberOfLines = 0
        titleLabel.textColor = .white
        
        comicImageView.backgroundColor = .marvelBlack
        comicImageView.layer.cornerRadius = 3
        comicImageView.clipsToBounds = true
    }
}

//
//  DescriptionCell.swift
//  MarvelChallenge
//
//  Created by Gabriel Mocelin on 03/03/20.
//  Copyright © 2020 Gabriel Mocelin. All rights reserved.
//

import UIKit

final class DescriptionCell: UITableViewCell {
    
    let descriptionLabel = UILabel(fontSize: 14, weight: .regular)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViewConfiguration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(with text: String) {
        descriptionLabel.text = text
    }
}

extension DescriptionCell: ViewConfigurator {
    func buildViewHierarchy() {
        addSubview(descriptionLabel)
    }
    
    func setupConstraints() {
        descriptionLabel.equalConstraintsTo(view: self, constant: 20)
    }
    
    func configureViews() {
        selectionStyle = .none
        backgroundColor = .clear
        descriptionLabel.textColor = .white
        descriptionLabel.numberOfLines = 0
    }
}

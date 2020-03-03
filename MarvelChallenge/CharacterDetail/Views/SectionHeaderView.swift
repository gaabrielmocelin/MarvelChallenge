//
//  SectionHeaderView.swift
//  MarvelChallenge
//
//  Created by Gabriel Mocelin on 03/03/20.
//  Copyright © 2020 Gabriel Mocelin. All rights reserved.
//

import UIKit

final class SectionHeaderCell: UITableViewCell {
    
    let titleLabel = UILabel(fontSize: 17, weight: .bold)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViewConfiguration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(with text: String) {
        titleLabel.text = text
    }
}

extension SectionHeaderCell: ViewConfigurator {
    func buildViewHierarchy() {
        addSubview(titleLabel)
    }
    
    func setupConstraints() {
        titleLabel.equalConstraintsTo(view: self, constant: 20)
    }
    
    func configureViews() {
        backgroundColor = .marvelDarkGray
        titleLabel.textColor = .white
    }
}

//
//  ViewConfigurator.swift
//  QuizChallenge
//
//  Created by Gabriel Mocelin on 29/01/20.
//  Copyright © 2020 ArcTouch. All rights reserved.
//

import Foundation

//helps to organize view coding
protocol ViewConfigurator {
    func setupViewConfiguration()
    func buildViewHierarchy()
    func configureViews()
    func setupConstraints()
}

extension ViewConfigurator {
    func setupViewConfiguration() {
        buildViewHierarchy()
        setupConstraints()
        configureViews()
    }
    
    func configureViews() {}
}

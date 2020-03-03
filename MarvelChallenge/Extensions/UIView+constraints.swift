//
//  UIView+constraints.swift
//  QuizChallenge
//
//  Created by Gabriel Mocelin on 29/01/20.
//  Copyright © 2020 ArcTouch. All rights reserved.
//

import UIKit

extension UIView {
    func equalConstraintsTo(view: UIView, constant: CGFloat = 0) {
        self.translatesAutoresizingMaskIntoConstraints = false
        let topConstraint = topAnchor.constraint(equalTo: view.topAnchor, constant: constant)
        let bottomConstraint = bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -constant)
        let leadingConstraint = leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: constant)
        let trailingConstraint = trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -constant)
        
        NSLayoutConstraint.activate([topConstraint, bottomConstraint, leadingConstraint, trailingConstraint])
    }
    
    func equalConstraintsToSafeArea(view: UIView, constant: CGFloat = 0) {
        self.translatesAutoresizingMaskIntoConstraints = false
        let topConstraint = topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: constant)
        let bottomConstraint = bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -constant)
        let leadingConstraint = leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: constant)
        let trailingConstraint = trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -constant)
        
        NSLayoutConstraint.activate([topConstraint, bottomConstraint, leadingConstraint, trailingConstraint])
    }
}

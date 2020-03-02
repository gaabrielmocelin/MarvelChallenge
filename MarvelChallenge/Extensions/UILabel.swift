//
//  UILabel.swift
//  QuizChallenge
//
//  Created by Gabriel Mocelin on 29/01/20.
//  Copyright © 2020 ArcTouch. All rights reserved.
//

import UIKit

extension UILabel {
    convenience init(fontSize: CGFloat, weight: UIFont.Weight) {
        self.init()
        self.font = UIFont.systemFont(ofSize: fontSize, weight: weight)
    }
}

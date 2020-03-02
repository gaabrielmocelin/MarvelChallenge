//
//  UIButtton.swift
//  QuizChallenge
//
//  Created by Gabriel Mocelin on 29/01/20.
//  Copyright © 2020 ArcTouch. All rights reserved.
//

import UIKit

extension UIButton {
    convenience init(fontSize: CGFloat, weight: UIFont.Weight, titleColor: UIColor = .white) {
        self.init(type: .system)
        self.titleLabel?.font = UIFont.systemFont(ofSize: fontSize, weight: weight)
        self.setTitleColor(titleColor, for: .normal)
    }
}

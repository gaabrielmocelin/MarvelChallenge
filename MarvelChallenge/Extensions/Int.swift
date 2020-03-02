//
//  Int.swift
//  QuizChallenge
//
//  Created by Gabriel Mocelin on 29/01/20.
//  Copyright © 2020 ArcTouch. All rights reserved.
//

import Foundation

extension Int {
    func toString() -> String {
        return self < 10 ? "0\(self)" : "\(self)"
    }
}

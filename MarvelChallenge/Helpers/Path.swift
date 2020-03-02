//
//  Path.swift
//  QuizChallenge
//
//  Created by Gabriel Mocelin on 30/01/20.
//  Copyright © 2020 ArcTouch. All rights reserved.
//

import Foundation

struct Path {
    private let baseUrl = "https://codechallenge.arctouch.com"
    
    func getQuiz() -> String {
        return "\(baseUrl)/quiz/1"
    }
}

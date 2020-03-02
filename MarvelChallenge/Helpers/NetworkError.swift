//
//  NetworkError.swift
//  QuizChallenge
//
//  Created by Gabriel Mocelin on 30/01/20.
//  Copyright © 2020 ArcTouch. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case invalidUrl
    case unableToParseJSON
}

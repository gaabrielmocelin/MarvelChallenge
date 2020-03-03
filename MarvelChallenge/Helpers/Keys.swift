//
//  Keys.swift
//  MarvelChallenge
//
//  Created by Gabriel Mocelin on 03/03/20.
//  Copyright © 2020 Gabriel Mocelin. All rights reserved.
//

import Foundation

struct Keys {
    static let marvelPublicKey = "d509a72eb44eb9bf5a030a9a5636782d"
    static let marvelPrivateKey = "726f10e751a00937bd9cbbb068c746f2e4b02d9d"
    
    enum ImageSize: String {
        case portraitLarge = "portrait_xlarge"
        case landscapeLarge = "landscape_xlarge"
        case portraitMedium = "portrait_medium"
    }
    
    var defaultParameters: [String: Any] {
        let timestamp = "\(Date().timeIntervalSinceNow)"
        let hash = "\(timestamp)\(Keys.marvelPrivateKey)\(Keys.marvelPublicKey)".md5()
        return [
            "ts": timestamp,
            "hash": hash,
            "apikey": Keys.marvelPublicKey,
        ]
    }
}

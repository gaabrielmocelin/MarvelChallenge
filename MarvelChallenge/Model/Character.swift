//
//  Character.swift
//  MarvelChallenge
//
//  Created by Gabriel Mocelin on 02/03/20.
//  Copyright © 2020 Gabriel Mocelin. All rights reserved.
//

import Foundation

struct Character: Codable {
    let id: Int
    let name: String
    let description: String
    let thumbnail: Thumbnail
    
    var imageUrl: String {
        return "\(thumbnail.path)/%@.\(thumbnail.extension)"
    }
}

struct Thumbnail: Codable {
    let path: String
    let `extension`: String
}

//
//  Comic.swift
//  MarvelChallenge
//
//  Created by Gabriel Mocelin on 03/03/20.
//  Copyright © 2020 Gabriel Mocelin. All rights reserved.
//

import Foundation

struct Comic {
    let id: Int
    let title: String
    let thumbnail: Thumbnail
    
    var imageUrl: String {
        return "\(thumbnail.path)/%@.\(thumbnail.extension)"
    }
}

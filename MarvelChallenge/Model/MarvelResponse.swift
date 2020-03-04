//
//  MarvelResponse.swift
//  MarvelChallenge
//
//  Created by Gabriel Mocelin on 02/03/20.
//  Copyright © 2020 Gabriel Mocelin. All rights reserved.
//

import Foundation

struct MarvelResponse<T: Decodable>: Decodable {
    let data: DataClass<T>
}

struct DataClass<T: Decodable>: Decodable {
    let total: Int
    let results: [T]
}

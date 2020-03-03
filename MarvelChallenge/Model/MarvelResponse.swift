//
//  MarvelResponse.swift
//  MarvelChallenge
//
//  Created by Gabriel Mocelin on 02/03/20.
//  Copyright © 2020 Gabriel Mocelin. All rights reserved.
//

import Foundation

// MARK: - Welcome
struct MarvelResponse<T: Decodable>: Decodable {
    let data: DataClass<T>
}

// MARK: - DataClass
struct DataClass<T: Decodable>: Decodable {
    let offset, limit, total, count: Int
    let results: [T]
}

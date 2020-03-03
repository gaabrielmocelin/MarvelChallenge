//
//  CharactersService.swift
//  MarvelChallenge
//
//  Created by Gabriel Mocelin on 02/03/20.
//  Copyright © 2020 Gabriel Mocelin. All rights reserved.
//

import Foundation
import CryptoSwift
import Alamofire

final class CharactersService {
    let marvelPublicKey = "d509a72eb44eb9bf5a030a9a5636782d"
    let marvelPrivateKey = "726f10e751a00937bd9cbbb068c746f2e4b02d9d"
    
    let baseUrl = "https://gateway.marvel.com/v1/public"
    let characters = "/characters"
    
    var defaultParameters: [String: Any] {
        let timestamp = "\(Date().timeIntervalSinceNow)"
        let hash = "\(timestamp)\(marvelPrivateKey)\(marvelPublicKey)".md5()
        return [
            "ts": timestamp,
            "hash": hash,
            "apikey": marvelPublicKey
        ]
    }
    
    func fetchCharacters() {
        AF.request("\(baseUrl)\(characters)",
                   method: .get,
                   parameters: defaultParameters,
                   encoding: URLEncoding.queryString,
                   headers: nil)
            .response { (snapshot) in
                print(snapshot.error)
                print(String(decoding: snapshot.data!, as: UTF8.self))
        }
    }
}

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

protocol CharactersServiceProtocol {
    func fetchCaracteres(offset: Int, limit: Int, completion: @escaping (Result<[Character], Error>) -> Void)
}

final class CharactersService: CharactersServiceProtocol {
    
    func fetchCaracteres(offset: Int, limit: Int, completion: @escaping (Result<[Character], Error>) -> Void) {
        var params = Keys().defaultParameters
        params["offset"] = offset
        params["limit"] = limit
        
        AF.request(Path().characteres(),
                   method: .get,
                   parameters: params,
                   encoding: URLEncoding.queryString,
                   headers: nil)
            .responseJSON { (response) in
                switch response.result {
                case .success(let dict):
                    if let dict = dict as? [String: Any], let marvelResponse = MarvelResponse(from: dict) {
                        completion(.success(marvelResponse.data.results))
                    } else {
                        completion(.failure(NetworkError.unableToParseJSON))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
        }
    }
}

final class CharactersServiceMock: CharactersServiceProtocol {
    func fetchCaracteres(offset: Int, limit: Int, completion: @escaping (Result<[Character], Error>) -> Void) {
        let ch1 = Character(id: 1, name: "Teste 1", description: "Teste 1", thumbnail: Thumbnail(path: "", extension: ""), comics: Comics(items: []), series: Comics(items: []))
        
        let ch2 = Character(id: 1, name: "Teste 2", description: "Teste 2", thumbnail: Thumbnail(path: "", extension: ""), comics: Comics(items: []), series: Comics(items: []))
        
        completion(.success([ch1, ch2]))
    }
}

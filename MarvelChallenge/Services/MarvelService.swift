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

protocol MarvelAPIService {
    func fetchCaracteres(offset: Int, limit: Int, completion: @escaping (Result<[Character], Error>) -> Void)
    func fetchComics(of char: Character, completion: @escaping (Result<[Character], Error>) -> Void)
}

final class MarvelAPI: MarvelAPIService {
    
    func fetchCaracteres(offset: Int, limit: Int, completion: @escaping (Result<[Character], Error>) -> Void) {
        performRequest(path: Path().characteres(), offset: offset, limit: limit, completion: completion)
    }
    
    func fetchComics(of char: Character, completion: @escaping (Result<[Character], Error>) -> Void) {
        performRequest(path: Path().comics(id: char.id), offset: nil, limit: nil, completion: completion)
    }
    
    ///generic request because responses have the same structure
    func performRequest<T: Decodable>(path: String, offset: Int?, limit: Int?, completion: @escaping (Result<[T], Error>) -> Void) {
        var params = Keys().defaultParameters
        
        if let offset = offset {
            params["offset"] = offset
        }
        
        if let limit = limit {
            params["limit"] = limit
        }
        
        AF.request(path,
                   method: .get,
                   parameters: params,
                   encoding: URLEncoding.queryString,
                   headers: nil)
            .responseJSON { (response) in
            switch response.result {
            case .success(let dict):
                if let dict = dict as? [String: Any], let marvelResponse = MarvelResponse<T>(from: dict) {
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

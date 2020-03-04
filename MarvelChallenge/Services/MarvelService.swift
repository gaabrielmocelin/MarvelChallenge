//
//  MarvelService.swift
//  MarvelChallenge
//
//  Created by Gabriel Mocelin on 03/03/20.
//  Copyright © 2020 Gabriel Mocelin. All rights reserved.
//
import Foundation
import CryptoSwift
import Alamofire

protocol MarvelAPIService {
    var totalCharacteresNumber: Int? { get }
    func fetchCaracteres(offset: Int, limit: Int, completion: @escaping (Result<[Character], Error>) -> Void)
    func fetchComics(of char: Character, completion: @escaping (Result<[Comic], Error>) -> Void)
}

final class MarvelAPI: MarvelAPIService {
    ///used to validate if has downloaded all the characters to not perform more requests.
    var totalCharacteresNumber: Int?
    
    func fetchCaracteres(offset: Int, limit: Int, completion: @escaping (Result<[Character], Error>) -> Void) {
        performRequest(path: Path().characteres(), offset: offset, limit: limit, completion: completion)
    }
    
    func fetchComics(of char: Character, completion: @escaping (Result<[Comic], Error>) -> Void) {
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
                    self.totalCharacteresNumber = marvelResponse.data.total
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



//Mark: MOCK
final class MarvelAPIMock: MarvelAPIService {
    
    var shouldFailRequests = false
    
    var totalCharacteresNumber: Int?
    
    let char3 = Character(id: 3, name: "Thanos", description: "Thanos description", thumbnail: Thumbnail(path: "", extension: "jpg"))
    
    func fetchCaracteres(offset: Int, limit: Int, completion: @escaping (Result<[Character], Error>) -> Void) {
        if shouldFailRequests {
            completion(.failure(NetworkError.unableToParseJSON))
        } else {
            let char1 = Character(id: 1, name: "Spider Man", description: "Spiderman description", thumbnail: Thumbnail(path: "", extension: "jpg"))
            let char2 = Character(id: 2, name: "Iron Man", description: "Ironman description", thumbnail: Thumbnail(path: "", extension: "jpg"))
            
            completion(.success([char1, char2, char3]))
        }
    }
    
    func fetchComics(of char: Character, completion: @escaping (Result<[Comic], Error>) -> Void) {
        if shouldFailRequests {
            completion(.failure(NetworkError.unableToParseJSON))
        } else {
            let comic1 = Comic(id: 1, title: "Avengers #1", thumbnail: Thumbnail(path: "", extension: ""))
            let comic2 = Comic(id: 2, title: "Avengers #2", thumbnail: Thumbnail(path: "", extension: ""))
            let comic3 = Comic(id: 3, title: "Avengers #3", thumbnail: Thumbnail(path: "", extension: ""))
            
            completion(.success([comic1, comic2, comic3]))
        }
    }
}

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
import AlamofireImage

protocol CharactersServiceProtocol {
    func fetchCaracteres(offset: Int, limit: Int, completion: @escaping (Result<[Character], Error>) -> Void)
    func fetchImage(imageURL: String, with size: Keys.ImageSize, completion: @escaping(Result<UIImage, Error>) -> Void)
}

final class CharactersService: CharactersServiceProtocol {
    
    private let imageCache = AutoPurgingImageCache()
    
    var defaultParameters: [String: Any] {
        let timestamp = "\(Date().timeIntervalSinceNow)"
        let hash = "\(timestamp)\(Keys.marvelPrivateKey)\(Keys.marvelPublicKey)".md5()
        return [
            "ts": timestamp,
            "hash": hash,
            "apikey": Keys.marvelPublicKey,
        ]
    }
    
    func fetchCaracteres(offset: Int, limit: Int, completion: @escaping (Result<[Character], Error>) -> Void) {
        var params = defaultParameters
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
    
    func fetchImage(imageURL: String, with size: Keys.ImageSize, completion: @escaping(Result<UIImage, Error>) -> Void) {
        let imagePath = String(format: imageURL, size.rawValue)
        if let cachedImage = imageCache.image(withIdentifier: imagePath) {
            completion(.success(cachedImage))
            return
        }
        
        AF.request(imagePath,
                   method: .get,
                   parameters: defaultParameters,
                   encoding: URLEncoding.queryString,
                   headers: nil)
            .responseImage { [unowned self] response in
                switch response.result {
                case .success(let image):
                    self.imageCache.add(image, withIdentifier: imagePath)
                    completion(.success(image))
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
    
    func fetchImage(imageURL: String, with size: Keys.ImageSize, completion: @escaping(Result<UIImage, Error>) -> Void) {
        completion(.success(UIImage()))
    }
}

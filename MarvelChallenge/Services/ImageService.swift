//
//  ImageService.swift
//  MarvelChallenge
//
//  Created by Gabriel Mocelin on 03/03/20.
//  Copyright © 2020 Gabriel Mocelin. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

protocol ImageServiceProtocol {
    func fetchImage(imageURL: String, with size: Keys.ImageSize, completion: @escaping(Result<UIImage, Error>) -> Void)
}

final class ImageService: ImageServiceProtocol {
    private let imageCache = AutoPurgingImageCache()
    
    func fetchImage(imageURL: String, with size: Keys.ImageSize, completion: @escaping(Result<UIImage, Error>) -> Void) {
        let imagePath = String(format: imageURL, size.rawValue)
        if let cachedImage = imageCache.image(withIdentifier: imagePath) {
            completion(.success(cachedImage))
            return
        }
        
        AF.request(imagePath,
                   method: .get,
                   parameters: Keys().defaultParameters,
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

final class ImageServiceMock: ImageServiceProtocol {
    func fetchImage(imageURL: String, with size: Keys.ImageSize, completion: @escaping(Result<UIImage, Error>) -> Void) {
        completion(.success(UIImage()))
    }
}

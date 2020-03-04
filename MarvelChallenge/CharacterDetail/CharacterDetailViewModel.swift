//
//  CharacterDetailViewModel.swift
//  MarvelChallenge
//
//  Created by Gabriel Mocelin on 03/03/20.
//  Copyright © 2020 Gabriel Mocelin. All rights reserved.
//

import UIKit

final class CharacterDetailViewModel: ViewModel {
    let coordinator: SceneCoordinator
    let character: Character
    let imageService: ImageServiceProtocol
    let marvelService: MarvelAPIService
    
    var comics: [Comic] = []
    
    init(coordinator: SceneCoordinator, character: Character, marvelService: MarvelAPIService, imageService: ImageServiceProtocol) {
        self.coordinator = coordinator
        self.character = character
        self.imageService = imageService
        self.marvelService = marvelService
    }
    
    func fetchImage(completion: @escaping (UIImage?) -> Void) {
        imageService.fetchImage(imageURL: character.imageUrl, with: .landscapeLarge) { (result) in
            switch result {
            case .success(let image):
                completion(image)
            case .failure(_):
                completion(nil)
            }
        }
    }
    
    func fetchComics(completion: @escaping (Error?) -> Void) {
        marvelService.fetchComics(of: character) { [weak self] (result) in
            switch result {
            case .success(let comics):
                self?.comics = comics
                completion(nil)
            case .failure(let error):
                completion(error)
            }
        }
    }
}

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
    
    init(coordinator: SceneCoordinator, character: Character, imageService: ImageServiceProtocol) {
        self.coordinator = coordinator
        self.character = character
        self.imageService = imageService
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
}

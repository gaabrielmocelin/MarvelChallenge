//
//  CharacterDetailViewModel.swift
//  MarvelChallenge
//
//  Created by Gabriel Mocelin on 03/03/20.
//  Copyright © 2020 Gabriel Mocelin. All rights reserved.
//

import Foundation

final class CharacterDetailViewModel: ViewModel {
    let coordinator: SceneCoordinator
    let character: Character
    let charactersService: CharactersServiceProtocol
    
    init(coordinator: SceneCoordinator, character: Character, charactersService: CharactersServiceProtocol) {
        self.coordinator = coordinator
        self.character = character
        self.charactersService = charactersService
    }
}

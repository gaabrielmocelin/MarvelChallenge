//
//  CharactersViewModel.swift
//  MarvelChallenge
//
//  Created by Gabriel Mocelin on 02/03/20.
//  Copyright © 2020 Gabriel Mocelin. All rights reserved.
//

import Foundation

final class CharactersViewModel: ViewModel {
    var coordinator: SceneCoordinator
    var marvelService: MarvelAPIService
    var imageService: ImageServiceProtocol
    
    var characteres: [Character] = []
    
    init(coordinator: SceneCoordinator) {
        self.coordinator = coordinator
        self.marvelService = MarvelAPI()
        self.imageService = ImageService()
    }
    
    func fetchCharacteres(completion: @escaping (Result<[IndexPath], Error>) -> Void) {
        //doesnt fetch anymore if has downloaded all the characteres
        guard let total = marvelService.totalCharacteresNumber, total > characteres.count else {
            completion(.success([]))
            return
        }
        
        marvelService.fetchCaracteres(offset: characteres.count, limit: 20) { [unowned self] (result) in
            switch result {
            case .success(let characteres):
                self.characteres.append(contentsOf: characteres)
                completion(.success(self.getIndexPathsToInsert(characteres)))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func openCharacterDetail(at indexPath: IndexPath) {
        let char = characteres[indexPath.row]
        let charViewModel = CharacterDetailViewModel(coordinator: coordinator,
                                                     character: char,
                                                     marvelService: marvelService,
                                                     imageService: imageService)
        
        coordinator.transition(to: .characterDetail(charViewModel), type: .push)
    }
    
    private func getIndexPathsToInsert(_ newCharacteres: [Character]) -> [IndexPath] {
       let startIndex = characteres.count - newCharacteres.count
       let endIndex = startIndex + newCharacteres.count
       return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
    }
}

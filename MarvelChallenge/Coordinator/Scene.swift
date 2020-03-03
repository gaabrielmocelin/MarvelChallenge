//
//  Scene.swift
//  DoctorCell
//
//  Created by Gabriel Mocelin on 30/11/18.
//  Copyright © 2018 Gabriel Mocelin. All rights reserved.
//

import UIKit

//Each ViewController has a correspondent Scene witch holds its viewModel
enum Scene {
    
    case characters(CharactersViewModel)
    case characterDetail(CharacterDetailViewModel)
    
    func viewController() -> UIViewController {
        switch self {
        case .characters(let viewModel): return CharactersViewController(viewModel: viewModel).embedInNavigation()
        case .characterDetail(let viewModel): return CharacterDetailViewController(viewModel: viewModel)
        }
    }
}

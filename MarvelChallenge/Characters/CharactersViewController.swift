//
//  CharactersViewController.swift
//  MarvelChallenge
//
//  Created by Gabriel Mocelin on 02/03/20.
//  Copyright © 2020 Gabriel Mocelin. All rights reserved.
//

import UIKit

final class CharactersViewController: UIViewController, SceneController {
    typealias T = CharactersViewModel
    var viewModel: CharactersViewModel
    
    init(viewModel: CharactersViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CharactersService().fetchCharacters()
    }
}

extension CharactersViewController: ViewConfigurator {
    func buildViewHierarchy() {
        
    }
    
    func setupConstraints() {
        
    }
    
    func configureViews() {
        
    }
}

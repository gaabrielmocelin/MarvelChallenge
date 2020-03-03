//
//  CharacterDetailViewController.swift
//  MarvelChallenge
//
//  Created by Gabriel Mocelin on 03/03/20.
//  Copyright © 2020 Gabriel Mocelin. All rights reserved.
//

import UIKit

final class CharacterDetailViewController: UIViewController, SceneController {
    typealias T = CharacterDetailViewModel
    var viewModel: CharacterDetailViewModel
    
    init(viewModel: CharacterDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewConfiguration()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if isMovingFromParent {
            popped()
        }
    }
}

extension CharacterDetailViewController: ViewConfigurator {
    func buildViewHierarchy() {
        
    }
    
    func setupConstraints() {
    
    }
    
    func configureViews() {
        view.backgroundColor = .marvelDarkGray
        navigationItem.title = viewModel.character.name
    }
}

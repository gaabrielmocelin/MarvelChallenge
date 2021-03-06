//
//  CharactersViewController.swift
//  MarvelChallenge
//
//  Created by Gabriel Mocelin on 02/03/20.
//  Copyright © 2020 Gabriel Mocelin. All rights reserved.
//

import UIKit

final class CharactersViewController: UIViewController, SceneController {
    //Mark: properties
    typealias T = CharactersViewModel
    var viewModel: CharactersViewModel
    
    //Mark: views
    lazy var collectionView: UICollectionView = {
        let layout = generateFlowLayout()
        let rect = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        let collectionView = UICollectionView(frame: rect, collectionViewLayout: layout)
        collectionView.alwaysBounceVertical = true
        return collectionView
    }()
    
    private let activityIndicator = ActivityIndicator()
    
    //Mark: functions
    init(viewModel: CharactersViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewConfiguration()
        
        activityIndicator.show(on: view)
        fetchCharacters()
    }
    
    private func fetchCharacters() {
        viewModel.fetchCharacteres { [unowned self] (result) in
            self.activityIndicator.hide()
            
            switch result {
            case .success(let indexes):
                self.collectionView.insertItems(at: indexes)
            case .failure(let error):
                self.presentAllert(title: "Failed to download some characteres", subtitle: error.localizedDescription)
            }
        }
    }
    
    private func generateFlowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        
        let padding: CGFloat = 10
        
        let width: CGFloat = self.view.frame.width / 2 - (padding * 2)
        let height: CGFloat = 300
        layout.itemSize = CGSize(width: width, height: height)
        layout.minimumLineSpacing = padding
        layout.minimumInteritemSpacing = padding
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        
        return layout
    }
}

extension CharactersViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.characteres.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, of: CharacterCell.self)
        cell.setup(with: viewModel.characteres[indexPath.row], imageService: viewModel.imageService)
        return cell
    }
}

extension CharactersViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.openCharacterDetail(at: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == viewModel.characteres.count - 10 {
            fetchCharacters()
        }
    }
}

extension CharactersViewController: ViewConfigurator {
    func buildViewHierarchy() {
        view.addSubview(collectionView)
    }
    
    func setupConstraints() {
        collectionView.equalConstraintsToSafeArea(view: view)
    }
    
    func configureViews() {
        navigationItem.title = "Marvel Characteres"
        view.backgroundColor = .marvelDarkGray
        collectionView.backgroundColor = .clear
        
        collectionView.register(type: CharacterCell.self)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

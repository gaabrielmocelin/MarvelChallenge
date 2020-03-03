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
    
    var imageView = UIImageView()
    var tableView = UITableView()
    
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
        
        viewModel.fetchImage { [weak self] (image) in
            if let image = image {
                self?.imageView.image = image
            }
        }
        
        viewModel.fetchComics { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if isMovingFromParent {
            popped()
        }
    }
}

extension CharacterDetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        case 1: return viewModel.comics.count
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(for: indexPath, of: DescriptionCell.self)
            cell.setup(with: viewModel.character.description)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(for: indexPath, of: ComicCell.self)
            cell.setup(with: viewModel.comics[indexPath.row], imageService: viewModel.imageService)
            return cell
        default: return UITableViewCell()
        }
    }
}

extension CharacterDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard section == 1 else { return nil }
        
        return SectionHeaderView(title: "Comics")
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard section == 1 else { return 0 }
        
        return 50
    }
}

extension CharacterDetailViewController: ViewConfigurator {
    func buildViewHierarchy() {
        view.addSubview(imageView)
        view.addSubview(tableView)
    }
    
    func setupConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 400).isActive = true
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func configureViews() {
        view.backgroundColor = .marvelDarkGray
        navigationItem.title = viewModel.character.name
        
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        
        tableView.register(type: DescriptionCell.self)
        tableView.register(type: ComicCell.self)
        tableView.dataSource = self
        tableView.delegate = self
    }
}

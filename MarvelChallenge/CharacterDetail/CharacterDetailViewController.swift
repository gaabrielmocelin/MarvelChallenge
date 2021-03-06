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
    
    // The variant sizes of image view for animation
    let imageViewDefaultHeight: CGFloat = 250
    let imageViewMinimunHeight: CGFloat = 100
    let imageViewMaxHeight: CGFloat = 350
    
    var imageViewHeightConstraint: NSLayoutConstraint?
    
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
        
        performFetchs()
    }
    
    private func performFetchs() {
        let activity = ActivityIndicator()
        activity.show(on: view)
        
        //dispatch group to present all data together after fetchs
        let group = DispatchGroup()
        
        group.enter()
        viewModel.fetchImage { [weak self] (image) in
            group.leave()
            if let image = image {
                self?.imageView.image = image
            } else {
                self?.presentAllert(title: "Failed to download character image.", subtitle: "Try again later.")
            }
        }
        
        group.enter()
        viewModel.fetchComics { [weak self] error in
            group.leave()
            self?.tableView.reloadData()
            if error != nil {
                self?.presentAllert(title: "Failed to download character comics.", subtitle: "Try again later.")
            }
        }
        
        group.notify(queue: .main) {
            activity.hide()
            self.imageView.isHidden = false
            self.tableView.isHidden = false
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
        case 1: return viewModel.comics.count > 0 ? 1 : 0
        case 2: return viewModel.comics.count
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
            //this header needs to be treated as a cell instead of a header for the animation of imageview
            //because headers stop scrolling on the top of table view.
            let cell = tableView.dequeueReusableCell(for: indexPath, of: SectionHeaderCell.self)
            cell.setup(with: "Comics")
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(for: indexPath, of: ComicCell.self)
            cell.setup(with: viewModel.comics[indexPath.row], imageService: viewModel.imageService)
            return cell
        default: return UITableViewCell()
        }
    }
}

extension CharacterDetailViewController: UIScrollViewDelegate, UITableViewDelegate {
    //calculate and perform animation to change the imageview height based on table view offset
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = imageViewDefaultHeight - (scrollView.contentOffset.y + imageViewDefaultHeight)
        imageViewHeightConstraint?.constant = min(max(y, imageViewMinimunHeight), imageViewMaxHeight)

        UIView.animate(withDuration: 0) {
            self.view.layoutIfNeeded()
        }
    }
}

extension CharacterDetailViewController: ViewConfigurator {
    func buildViewHierarchy() {
        view.addSubview(tableView)
        view.addSubview(imageView)
    }
    
    func setupConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        imageViewHeightConstraint = imageView.heightAnchor.constraint(equalToConstant: imageViewDefaultHeight)
        imageViewHeightConstraint?.isActive = true
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func configureViews() {
        view.backgroundColor = .marvelDarkGray
        navigationItem.title = viewModel.character.name
        
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets(top: imageViewDefaultHeight, left: 0, bottom: 0, right: 0)
        
        tableView.register(type: SectionHeaderCell.self)
        tableView.register(type: DescriptionCell.self)
        tableView.register(type: ComicCell.self)
        tableView.dataSource = self
        tableView.delegate = self
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        imageView.isHidden = true
        tableView.isHidden = true
    }
}

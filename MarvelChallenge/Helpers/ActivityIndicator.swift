//
//  ActivityIndicator.swift
//  MarvelChallenge
//
//  Created by Gabriel Mocelin on 03/03/20.
//  Copyright © 2020 Gabriel Mocelin. All rights reserved.
//

import UIKit

class ActivityIndicator {
    
    var containerView = UIView()
    var progressView = UIView()
    var activityIndicator = UIActivityIndicatorView()
    
    init () {
        setupViewConfiguration()
    }
    
    open func show(on view: UIView) {
        view.addSubview(containerView)
        containerView.equalConstraintsTo(view: view)
        
        activityIndicator.startAnimating()
    }
    
    open func hide() {
        UIView.animate(withDuration: 0.2, animations: {
            self.containerView.alpha = 0
        }) { (_) in
            self.activityIndicator.stopAnimating()
            self.containerView.removeConstraints(self.containerView.constraints)
            self.containerView.removeFromSuperview()
        }
    }
}

extension ActivityIndicator: ViewConfigurator {
    func buildViewHierarchy() {
        progressView.addSubview(activityIndicator)
        containerView.addSubview(progressView)
    }
    
    func setupConstraints() {
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        progressView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        progressView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        progressView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerYAnchor.constraint(equalTo: progressView.centerYAnchor).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: progressView.centerXAnchor).isActive = true
        activityIndicator.heightAnchor.constraint(equalToConstant: 40).isActive = true
        activityIndicator.widthAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func configureViews() {
        progressView.backgroundColor = #colorLiteral(red: 0.2666666667, green: 0.2666666667, blue: 0.2666666667, alpha: 0.7)
        progressView.clipsToBounds = true
        progressView.layer.cornerRadius = 10
        
        activityIndicator.style = .whiteLarge
    }
}

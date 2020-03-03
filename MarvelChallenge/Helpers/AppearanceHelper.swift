//
//  AppearanceHelper.swift
//  MarvelChallenge
//
//  Created by Gabriel Mocelin on 02/03/20.
//  Copyright © 2020 Gabriel Mocelin. All rights reserved.
//

import UIKit

public struct AppearanceHelper {
    static public func setupNavigationBarAppearance() {
        let appearence = UINavigationBar.appearance()
        appearence.prefersLargeTitles = true
        
        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
            navBarAppearance.backgroundColor = .marvelDarkGray
            
            UINavigationBar.appearance(whenContainedInInstancesOf: [UINavigationController.self]).standardAppearance = navBarAppearance
            UINavigationBar.appearance(whenContainedInInstancesOf: [UINavigationController.self]).scrollEdgeAppearance = navBarAppearance
        } else {
            appearence.tintColor = .white
            appearence.barTintColor = .marvelDarkGray
            appearence.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            appearence.isTranslucent = true
        }
    }
}



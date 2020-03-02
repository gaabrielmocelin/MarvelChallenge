//
//  AppDelegate.swift
//  MarvelChallenge
//
//  Created by Gabriel Mocelin on 02/03/20.
//  Copyright © 2020 Gabriel Mocelin. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupWindow()
        return true
    }
    
    private func setupWindow() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        window?.makeKeyAndVisible()
        
        setupInitialScene()
    }
    
    private func setupInitialScene() {
        guard let window = window else {
            fatalError("There is no window to present any scene")
        }
        
        let coordinator = Coordinator(window: window)
        
        let charactersViewModel = CharactersViewModel(coordinator: coordinator)
        coordinator.transition(to: .characters(charactersViewModel), type: .root)
    }
}


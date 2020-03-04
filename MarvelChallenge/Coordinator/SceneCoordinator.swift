//
//  SceneCoordinator.swift
//  DoctorCell
//
//  Created by Gabriel Mocelin on 30/11/18.
//  Copyright © 2018 Gabriel Mocelin. All rights reserved.
//
import UIKit

//handles all the navigation flow
protocol SceneCoordinator {
    init(window: UIWindow)

    func transition(to scene: Scene, type: SceneTransitionType)
    func transition(to scene: Scene, type: SceneTransitionType, presentationStyle: UIModalPresentationStyle)
    
    func dismiss(animated: Bool)
    func didPop()
}

extension SceneCoordinator {
    func transition(to scene: Scene, type: SceneTransitionType) {
        transition(to: scene, type: type, presentationStyle: .fullScreen)
    }
}

final class Coordinator: SceneCoordinator {
    //Mark: properties
    fileprivate let window: UIWindow
    
    var currentViewController: UIViewController
    
    //Mark: Init
    required init(window: UIWindow) {
        self.window = window
        currentViewController = window.rootViewController ?? UIViewController()
    }
    
    //Mark: Push
    func transition(to scene: Scene, type: SceneTransitionType, presentationStyle: UIModalPresentationStyle) {
        let viewController = scene.viewController()
        viewController.modalPresentationStyle = presentationStyle
        
        switch type {
        case .root:
            window.rootViewController = viewController
            currentViewController = actualViewController(for: viewController)
        case .push:
            guard let navigationController = currentViewController.navigationController else {
                fatalError("can not present vc without a current navigation")
            }
            navigationController.pushViewController(viewController, animated: true)
            currentViewController = actualViewController(for: viewController)
        case .modal:
            currentViewController.present(viewController, animated: true, completion: nil)
            currentViewController = actualViewController(for: viewController)
        }
    }
    
    
    //Mark: Dismiss
    func dismiss(animated: Bool) {
        if let presenter = currentViewController.presentingViewController {
            currentViewController.dismiss(animated: animated, completion: nil)
            currentViewController = actualViewController(for: presenter)
        }else if let navigationController = currentViewController.navigationController {
            navigationController.popViewController(animated: animated)
            currentViewController = actualViewController(for: navigationController.viewControllers.last!)
        }
    }
    
    //updates the current vc if the pop was made direct from system
    public func didPop() {
        if let navigationController = currentViewController.navigationController {
            currentViewController = actualViewController(for: navigationController.viewControllers.last!)
        }
    }
    
    //Mark: helper
    /// if the controller is a navigation, returns the vc on the top of the stack
    func actualViewController(for viewController: UIViewController) -> UIViewController {
        if let navigationController = viewController as? UINavigationController {
            return navigationController.viewControllers.last!
        } else {
            return viewController
        }
    }
}

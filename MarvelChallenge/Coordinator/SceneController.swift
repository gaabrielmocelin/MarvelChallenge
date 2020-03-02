//
//  SceneController.swift
//  DoctorCell
//
//  Created by Gabriel Mocelin on 30/11/18.
//  Copyright © 2018 Gabriel Mocelin. All rights reserved.
//

import UIKit

//view controllers must conform to this protocol
protocol SceneController {
    associatedtype T: ViewModel
    var viewModel: T {get}
    
    init(viewModel: T)
}

extension SceneController where Self: UIViewController {
    func embedInNavigation() -> UINavigationController {
        return UINavigationController(rootViewController: self)
    }
}

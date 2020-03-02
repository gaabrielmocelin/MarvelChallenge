//
//  UIViewController.swift
//  QuizChallenge
//
//  Created by Gabriel Mocelin on 30/01/20.
//  Copyright © 2020 ArcTouch. All rights reserved.
//

import UIKit

extension UIViewController {
    func presentAllert(title: String, subtitle: String, buttonTitle: String, action: @escaping () -> Void) {
        let allert = UIAlertController(title: title, message: subtitle, preferredStyle: .alert)
        
        allert.addAction(UIAlertAction(title: buttonTitle, style: .cancel, handler: { (handler) in
            allert.dismiss(animated: true)
            action()
        }))
        
        present(allert, animated: true)
    }
}

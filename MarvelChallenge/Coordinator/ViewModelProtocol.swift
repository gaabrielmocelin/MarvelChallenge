//
//  ViewModelProtocol.swift
//  DoctorCell
//
//  Created by Gabriel Mocelin on 30/11/18.
//  Copyright © 2018 Gabriel Mocelin. All rights reserved.
//

import Foundation

//view models must conform to this protocol
protocol ViewModel {
    var coordinator: SceneCoordinator { get }
}

//
//  Coordinator.swift
//  ProjectManager
//
//  Created by Derrick kim on 9/7/22.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController? { get set }
    var children: [Coordinator]? { get set }
    
    func eventOccurred(with type: Event)
    func start()
}

enum Event {
    case plusButtonTapped
    case tagbleCellTapped
}

protocol Coordinating {
    var coordinator: Coordinator? { get set }
}

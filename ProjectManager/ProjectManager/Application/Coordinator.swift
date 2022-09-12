//
//  Coordinator.swift
//  ProjectManager
//
//  Created by 이원빈 on 2022/09/09.
//

import UIKit

protocol Coordinator {
    var parentCoordinator: Coordinator? { get set }
    var children: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}

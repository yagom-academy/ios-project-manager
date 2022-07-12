//
//  Coordinator.swift
//  ProjectManager
//
//  Created by Lingo on 2022/07/11.
//

import UIKit

protocol Coordinator: AnyObject {
  var navigationController: UINavigationController { get set }
  var childCoordinators: [Coordinator] { get set }
  
  func start()
}

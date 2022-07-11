//
//  Coordinator.swift
//  ProjectManager
//
//  Created by Lingo on 2022/07/11.
//

import UIKit

protocol Coordinator {
  var navigationController: UINavigationController { get }
  var childCoordinators: [Coordinator] { get set }
  
  func start()
}

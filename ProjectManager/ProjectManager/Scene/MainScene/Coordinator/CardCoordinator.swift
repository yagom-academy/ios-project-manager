//
//  CardCoordinator.swift
//  ProjectManager
//
//  Created by Lingo on 2022/07/11.
//

import UIKit

final class CardCoordinator: Coordinator {
  var navigationController: UINavigationController
  var childCoordinators: [Coordinator] = []
  
  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  func start() {}
}

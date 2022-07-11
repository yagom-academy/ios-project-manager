//
//  AppCoordinator.swift
//  ProjectManager
//
//  Created by Lingo on 2022/07/11.
//

import UIKit

final class AppCoordinator: Coordinator {
  var navigationController: UINavigationController
  var childCoordinators: [Coordinator] = []
  
  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  func start() {
    let cardCoordinator = CardCoordinator(navigationController: navigationController)
    childCoordinators.append(cardCoordinator)
    cardCoordinator.start()
  }
}

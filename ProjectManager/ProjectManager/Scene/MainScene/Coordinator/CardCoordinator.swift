//
//  CardCoordinator.swift
//  ProjectManager
//
//  Created by Lingo on 2022/07/11.
//

import UIKit

protocol CardCoordinator: Coordinator {
  func toAddition()
  func toDetail(of card: Card)
}

final class DefaultCardCoordinator: CardCoordinator {
  var navigationController: UINavigationController
  var childCoordinators: [Coordinator] = []
  let viewModel = DefaultCardListViewModel()
  
  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  func start() {
    let cardListViewController = CardListViewController(viewModel: viewModel, coordinator: self)
    navigationController.pushViewController(cardListViewController, animated: true)
  }
  
  func toAddition() {
    let cardAdditionViewController = CardAdditionViewController(viewModel: viewModel)
    cardAdditionViewController.modalPresentationStyle = .formSheet
    navigationController.present(cardAdditionViewController, animated: true)
  }
  
  func toDetail(of card: Card) {
    let cardDetailViewController = CardDetailViewController(viewModel: viewModel, card: card)
    cardDetailViewController.modalPresentationStyle = .formSheet
    navigationController.present(cardDetailViewController, animated: true)
  }
}

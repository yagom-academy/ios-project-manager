//
//  DefaultCardCoordinator.swift
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
  
  private let useCase = DefaultCardUseCase(
    repository: DefaultCardRepository(
      localCoreDataService: DefaultCardCoreDataService(storage: CoreDataStorage.standard),
      realtimeDatabaseService: DefaultRealtimeDatabaseService()
    )
  )
  
  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  func start() {
    let cardListViewModel = CardListViewModel(useCase: useCase)
    let cardListViewController = CardListViewController(viewModel: cardListViewModel, coordinator: self)
    navigationController.pushViewController(cardListViewController, animated: true)
  }
  
  func toAddition() {
    let cardAdditionViewModel = CardAdditionViewModel(useCase: useCase)
    let cardAdditionViewController = CardAdditionViewController(viewModel: cardAdditionViewModel)
    cardAdditionViewController.modalPresentationStyle = .formSheet
    navigationController.present(cardAdditionViewController, animated: true)
  }
  
  func toDetail(of card: Card) {
    let cardDetailViewModel = CardDetailViewModel(useCase: useCase)
    let cardDetailViewController = CardDetailViewController(viewModel: cardDetailViewModel, card: card)
    cardDetailViewController.modalPresentationStyle = .formSheet
    navigationController.present(cardDetailViewController, animated: true)
  }
}

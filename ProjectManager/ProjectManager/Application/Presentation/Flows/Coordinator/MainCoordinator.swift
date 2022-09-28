//
//  MainCoordinator.swift
//  ProjectManager
//
//  Created by Derrick kim on 9/7/22.
//

import UIKit

final class MainCoordinator: CoordinatorProtocol {
    var navigationController: UINavigationController?
    var childCoordinators: [CoordinatorProtocol] = []
    var parentCoordinator: CoordinatorProtocol?
    
    private var cardViewModel = CardViewModel()
    private var cardHistoryViewModel = CardHistoryViewModel()

    func start() {
        let cardListViewController = CardListViewController(viewModel: cardViewModel,
                                                            coordinator: self)
        cardListViewController.coordinator = self
        childCoordinators.append(self)
        navigationController?.setViewControllers([cardListViewController],
                                                 animated: true)
    }
    
    func presentEnrollmentViewController() {
        let cardEnrollmentViewController = CardEnrollmentViewController(viewModel: cardViewModel,
                                                                        coodinator: self)
        navigationController?.present(cardEnrollmentViewController,
                                      animated: true)
    }
    
    func presentDetailViewController(_ model: CardModel) {
        let cardDetailViewController = CardDetailViewController(viewModel: cardViewModel,
                                                                model: model)
        navigationController?.present(cardDetailViewController,
                                      animated: true)
    }
    
    func presentTableViewCellActionSheet(_ sourceView: UIView,
                                         model: CardModel,
                                         firstCard: CardType,
                                         secondCard: CardType) {
        guard let cell = sourceView.subviews.first else { return }
        
        let alertViewController = UIAlertController(title: nil,
                                                    message: nil,
                                                    preferredStyle: .actionSheet)
        
        alertViewController.modalPresentationStyle = .popover
        alertViewController.popoverPresentationController?.permittedArrowDirections = .up
        
        alertViewController.popoverPresentationController?.sourceView = sourceView
        alertViewController.popoverPresentationController?.sourceRect = CGRect(x: cell.frame.midX,
                                                                               y: cell.frame.midY,
                                                                               width: 1,
                                                                               height: 1)
        let firstAction = UIAlertAction(title: firstCard.moveToAnotherSection,
                                        style: .default) { [weak self] _ in
            self?.cardViewModel.move(model,
                                     to: firstCard)
        }
        
        let secondAction = UIAlertAction(title: secondCard.moveToAnotherSection,
                                         style: .default) { [weak self] _ in
            self?.cardViewModel.move(model,
                                     to: secondCard)
        }
        
        alertViewController.addAction(firstAction)
        alertViewController.addAction(secondAction)
        navigationController?.modalPresentationStyle = .popover
        
        navigationController?.present(alertViewController,
                                      animated: true)
        
    }
    
    func presentHistoryViewActionSheet(_ barButton: UIBarButtonItem) {
        let controller = CardHistoryViewController(viewModel: cardHistoryViewModel,
                                                   coordinator: self)
        controller.modalPresentationStyle = .popover
        controller.preferredContentSize = CGSize(width: 450, height: 450)

        guard let popover = controller.popoverPresentationController else { return }
        popover.barButtonItem = barButton
        navigationController?.present(controller,
                                      animated: true)
    }
    
    func childDidFinish(_ child: CoordinatorProtocol?) {
        for (index, coordinator) in childCoordinators.enumerated() where coordinator === child {
            childCoordinators.remove(at: index)
            break
        }
    }
}

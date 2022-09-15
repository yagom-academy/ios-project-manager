//
//  MainCoordinator.swift
//  ProjectManager
//
//  Created by Derrick kim on 9/7/22.
//

import UIKit

final class MainCoordinator: CoordinatorProtocol {
    var navigationController: UINavigationController?
    var children = [CoordinatorProtocol]()
    private var cardViewModel = CardViewModel()
    
    func start() {
        let cardLisitViewController = CardListViewController(viewModel: cardViewModel,
                                                             coordinator: self)
        cardLisitViewController.coordinator = self
        children.append(self)
        navigationController?.setViewControllers([cardLisitViewController],
                                                 animated: true)
    }
    
    func presentEnrollmentViewController() {
        let cardEnrollmentViewController = CardEnrollmentViewController(viewModel: cardViewModel,
                                                                        coodinator: self)
        cardEnrollmentViewController.modalPresentationStyle = .formSheet
        
        navigationController?.present(cardEnrollmentViewController,
                                      animated: true)
    }
    
    func presentDetailViewController(_ model: CardModel) {
        let cardDetailViewController = CardDetailViewController(viewModel: cardViewModel,
                                                                model: model)
        
        navigationController?.present(cardDetailViewController,
                                      animated: true)
    }

    func presentAlertActionSheet(_ sourceView: UIView,
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

        navigationController?.present(alertViewController,
                                      animated: true)
    }

    func childDidFinish(_ child: CoordinatorProtocol?) {
        for (index, coordinator) in children.enumerated() where coordinator === child {
            children.remove(at: index)
            break
        }
    }
}

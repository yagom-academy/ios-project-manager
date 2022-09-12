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
        let cardEnrollmentViewController = CardEnrollmentViewController(viewModel: cardViewModel)
        cardEnrollmentViewController.modalPresentationStyle = .formSheet
        
        navigationController?.present(cardEnrollmentViewController,
                                      animated: true)
    }
    
    func presentDetailViewController(_ model: TodoListModel) {
        let cardDetailViewController = CardDetailViewController(viewModel: cardViewModel,
                                                                model: model)
        
        navigationController?.present(cardDetailViewController,
                                      animated: true)
    }
    
    func childDidFinish(_ child: CoordinatorProtocol?) {
        for (index, coordinator) in children.enumerated() where coordinator === child {
            children.remove(at: index)
            break
        }
    }
}

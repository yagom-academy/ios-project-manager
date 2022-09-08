//
//  MainCoordinator.swift
//  ProjectManager
//
//  Created by Derrick kim on 9/7/22.
//

import UIKit

typealias CoordinatingViewController = UIViewController & Coordinating

final class MainCoordinator: Coordinator {
    var navigationController: UINavigationController?
    var children = [Coordinator]()
    private var cardViewModel = CardViewModel()
    
    func eventOccurred(with type: Event) {
        switch type {
        case .plusButtonTapped:
            let cardEnrollmentViewController: CoordinatingViewController = CardEnrollmentViewController()
            
            navigationController?.setViewControllers([cardEnrollmentViewController],
                                                     animated: true)
        case .tableViewCellTapped:
            let cardDetailViewController: CoordinatingViewController = CardDetailViewController()
            
            navigationController?.setViewControllers([cardDetailViewController],
                                                     animated: true)
        }
    }
    
    func start() {
        var cardLisitViewController: CoordinatingViewController = CardListViewController(viewModel: cardViewModel,
                                                                                         coordinator: self)
        cardLisitViewController.coordinator = self
        
        navigationController?.setViewControllers([cardLisitViewController],
                                                 animated: true)
    }
    
    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in children.enumerated() where coordinator === child {
            children.remove(at: index)
            break
        }
    }
}

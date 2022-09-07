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
    var children: [Coordinator]? = []
    private var cardViewModel = CardViewModel()
    
    func start() {
        var cardLisitViewController: CoordinatingViewController = CardListViewController(viewModel: cardViewModel, coordinator: self)
        cardLisitViewController.coordinator = self
        
        children?.append(self)
        navigationController?.setViewControllers([cardLisitViewController],
                                                 animated: true)
    }
}

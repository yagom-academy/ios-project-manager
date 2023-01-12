//
//  MainViewController.swift
//  ProjectManager
//
//  Created by summercat on 2023/01/12.
//

import UIKit

final class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
    }

    private func configureNavigationBar() {
        navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
        title = Namespace.NavigationTitle
        
        let plusButton = UIBarButtonItem(image: UIImage(systemName: Namespace.PlusImage),
                                         style: .plain,
                                         target: self,
                                         action: nil)
        navigationItem.rightBarButtonItem = plusButton
    }
}

extension MainViewController {
    enum Namespace {
        static let NavigationTitle = "Project Manager"
        static let PlusImage = "plus"
    }
}

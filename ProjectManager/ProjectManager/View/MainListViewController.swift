//
//  ProjectManager - MainListViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

final class ViewController: UIViewController {

    private lazy var collectionView = UICollectionView(frame: .zero)
    // let viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation()
    }
    
    private func configureNavigation() {
        view.backgroundColor = .white
        title = NameSpace.projectName
        
        let addProjectButton = UIBarButtonItem(barButtonSystemItem: .add,
                                               target: self,
                                               action: #selector(addProject))
        
        navigationItem.rightBarButtonItem = addProjectButton
    }
    
    @objc
    private func addProject() {
        let addProjectViewController = AddProjectViewController()
        addProjectViewController.modalPresentationStyle = .formSheet
        let modalViewWithNavigation = UINavigationController(rootViewController: addProjectViewController)
        navigationController?.present(modalViewWithNavigation, animated: true)
    }
}

private enum NameSpace {
    static let projectName = "Project Manager"
}

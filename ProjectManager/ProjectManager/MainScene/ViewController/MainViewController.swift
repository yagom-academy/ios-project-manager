//
//  ProjectManager - MainViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

final class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationViewUI()
        configureViewUI()
        configureCollectionViewUI()
    }
}

extension MainViewController {
    private func configureDatasource() {
    }
}

// MARK: UI
extension MainViewController {
    private func configureNavigationViewUI() {
        navigationItem.title = "Project Manager"
        navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .add)
    }
    
    private func configureViewUI() {
        view.backgroundColor = .systemBackground
    }
    
    private func configureCollectionViewUI() {
    }
}

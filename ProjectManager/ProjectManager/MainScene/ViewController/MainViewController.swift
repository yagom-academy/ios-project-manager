//
//  ProjectManager - MainViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

final class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationView()
        configureView()
    }
}

extension MainViewController {
    private func configureNavigationView() {
        navigationController?.title = "ProjectManager"
        navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .add)
    }
    
    private func configureView() {
        view.backgroundColor = .systemBackground
    }
}

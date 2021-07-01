//
//  ProjectManager - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class ProjectManagerViewController: UIViewController {

    let projectManagerStackView = ProjectManagerStackView()
    let titleLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "소개팅 필승 공략"
        configureStackView()
    }
}

// MARK: -StackView AutoLayout
extension ProjectManagerViewController {
    private func configureStackView() {
        view.addSubview(projectManagerStackView)
        
        NSLayoutConstraint.activate([
            projectManagerStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            projectManagerStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            projectManagerStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            projectManagerStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}

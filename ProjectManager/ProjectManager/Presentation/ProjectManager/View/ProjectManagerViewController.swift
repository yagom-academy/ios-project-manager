//
//  ProjectManager - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

final class ProjectManagerViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationController()
        configureView()
    }
    
    private func configureNavigationController() {
        if let navigationController = self.navigationController {
            let navigationBar = navigationController.navigationBar
            navigationBar.backgroundColor = UIColor.systemGray
            let rightAddButton = UIBarButtonItem(barButtonSystemItem: .add, target: self,
                                                action: #selector(tapNavigationAddButton))
            navigationController.title = "Project Manager"
            navigationItem.rightBarButtonItem = rightAddButton
        }
    }
    
    private func configureView() {
        self.view.backgroundColor = UIColor.systemGray3
    }
    
    @objc
    private func tapNavigationAddButton() {
        // TODO: Add some action
    }
}


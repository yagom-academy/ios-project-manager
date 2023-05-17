//
//  ProjectManager - ProjectManagerViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

final class ProjectManagerViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        title = "Project Manager"
        
        let addProjectButton = UIBarButtonItem(barButtonSystemItem: .add,
                                             target: self,
                                             action: #selector(addProject))
        navigationItem.rightBarButtonItem = addProjectButton
    }
    
    @objc
    private func addProject() {
        let rootViewController = AddProjectViewController()
        let navigationController = UINavigationController(rootViewController: rootViewController)
        navigationController.modalPresentationStyle = UIModalPresentationStyle.formSheet
        
        self.present(navigationController, animated: true, completion: nil)
    }
}


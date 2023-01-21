//
//  ProjectManager - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class ProjectsViewController: UIViewController {

    enum Constant {
        static let navigationTitle = "Project Manager"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationItem()
    }

    override func loadView() {
        super.loadView()
        self.view = ProjectsManageView()
    }

    private func configureNavigationItem() {
        navigationItem.title = Constant.navigationTitle
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showAddProjectView))
    }

    @objc private func showAddProjectView() {
        let addProjectViewController = AddProjectViewController()
        self.present(addProjectViewController, animated: true)
    }
}

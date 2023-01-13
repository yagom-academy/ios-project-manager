//
//  ProjectManager - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class ProjectsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    private func configureUI() {
        configureTableView()
    }

    override func loadView() {
        super.loadView()
        self.view = ProjectsManageView()
    }

    private func configureTableView() {

    }
}

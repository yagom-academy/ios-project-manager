//
//  ProjectManager - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class ProjectsViewController: UIViewController {

    let projectsManageView = ProjectsManageView()

    enum Constant {
        static let navigationTitle = "Project Manager"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationItem()
        configureTableView()
    }

    override func loadView() {
        super.loadView()
        self.view = projectsManageView
    }

    private func configureTableView() {
        projectsManageView.todoViewDelegate = self
        projectsManageView.todoViewDataSource = self
        projectsManageView.doingViewDelegate = self
        projectsManageView.doingViewDataSource = self
        projectsManageView.doneViewDelegate = self
        projectsManageView.doneViewDataSource = self

        projectsManageView.registerAllTableViews(cellClass: TaskCell.self, forCellReuseIdentifier: TaskCell.cellIdentifier)
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

extension ProjectsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView {
        case projectsManageView.fetchTodoTableView():
            let cell = projectsManageView.dequeueReusableToDoCellWith(identifier: TaskCell.cellIdentifier) ?? UITableViewCell()
            return cell
        case projectsManageView.fetchDoingTableView():
            let cell = projectsManageView.dequeueReusableDoingCellWith(identifier: TaskCell.cellIdentifier) ?? UITableViewCell()
            return cell
        case projectsManageView.fetchDoneTableView():
            let cell = projectsManageView.dequeueToDoReusableDoneCellWith(identifier: TaskCell.cellIdentifier) ?? UITableViewCell()
            return cell
        default:
            return UITableViewCell()
        }
    }
}

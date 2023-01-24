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
            guard let cell = projectsManageView.dequeueReusableToDoCellWith(identifier: TaskCell.cellIdentifier) as? TaskCell else {
                return UITableViewCell()
            }
            cell.configureData(task: Task(title: "제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목", description: "내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용", date: Date(), status: .doing))
            return cell
        case projectsManageView.fetchDoingTableView():
            guard let cell = projectsManageView.dequeueReusableDoingCellWith(identifier: TaskCell.cellIdentifier) as? TaskCell else {
                return UITableViewCell()
            }
            return cell
        case projectsManageView.fetchDoneTableView():
            guard let cell = projectsManageView.dequeueToDoReusableDoneCellWith(identifier: TaskCell.cellIdentifier) as? TaskCell else {
                return UITableViewCell()
            }
            return cell
        default:
            return UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

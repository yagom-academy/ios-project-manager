//
//  ProjectManager - ProjectListViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

final class ProjectListViewController: UIViewController {
    typealias DataSource = UITableViewDiffableDataSource<Int, Project>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, Project>

    // MARK: Properties
    private var projectList: [Project] = DummyProjects.projects
    private var todoList: [Project] {
        return projectList.filter{ $0.status == .todo }
    }

    private var doingList: [Project] {
        return projectList.filter{ $0.status == .doing }
    }

    private var doneList: [Project] {
        return projectList.filter{ $0.status == .done }
    }

    private let projectManager = ProjectManager()
    private lazy var projectListView: ProjectListView = {
        let view = ProjectListView(frame: view.bounds)
        view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        return view
    }()

    private var todoDataSource: DataSource?
    private var doingDataSource: DataSource?
    private var doneDataSource: DataSource?

    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigationBar()
        configureView()
        configureDataSource()
        configureSnapshots()
    }

    // MARK: Configure NavigationBar
    private func makeRightNavigationBarButton() -> UIBarButtonItem {
        let touchUpAddButtonAction = UIAction { [weak self] _ in
            self?.present(ProjectViewController(), animated: false)
        }

        let addButton = UIBarButtonItem(systemItem: .add, primaryAction: touchUpAddButtonAction)

        return addButton
    }

    private func configureNavigationBar() {
        navigationItem.title = "프로젝트 매니저"
        navigationItem.rightBarButtonItem = makeRightNavigationBarButton()
    }

    // MARK: Configure View
    private func configureView() {
        view.addSubview(projectListView)
    }

    // MARK: Configure DataSource
    private func makeDataSource(tableView: UITableView) -> DataSource {
        let dataSource = DataSource(tableView: tableView) { tableView, indexPath, project in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ProjectTableViewCell.reuseIdentifier) as?
                    ProjectTableViewCell else {
                return UITableViewCell()
            }

            cell.configure(with: project)

            return cell
        }

        return dataSource
    }

    private func configureDataSource() {
        todoDataSource = makeDataSource(tableView: projectListView.todoTableView)
        doingDataSource = makeDataSource(tableView: projectListView.doingTableView)
        doneDataSource = makeDataSource(tableView: projectListView.doneTableView)
    }

    private func configureSnapshot(dataSource: DataSource, items: [Project]) {
        var snapshot = Snapshot()

        snapshot.appendSections([0])
        snapshot.appendItems(items)
        dataSource.apply(snapshot)
    }

    private func configureSnapshots() {
        guard let todoDataSource,
              let doingDataSource,
              let doneDataSource else {
            fatalError("데이터소스 없음")
        }

        configureSnapshot(dataSource: todoDataSource, items: todoList)
        configureSnapshot(dataSource: doingDataSource, items: doingList)
        configureSnapshot(dataSource: doneDataSource, items: doneList)
    }
}

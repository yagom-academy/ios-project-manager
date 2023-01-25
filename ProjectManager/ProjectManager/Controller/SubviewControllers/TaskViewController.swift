//
//  TodoViewController.swift
//  ProjectManager
//
//  Created by jin on 1/24/23.
//

import UIKit

class TaskViewController: UIViewController {

    enum Section {
        case main
    }

    var type: TaskStatus
    var filteredTasks: [Task] = [] {
        didSet {
            applySnapShot()
        }
    }
    var dataSource: UITableViewDiffableDataSource<Section, Task>

    init(type: TaskStatus) {
        self.type = type
        self.dataSource = UITableViewDiffableDataSource<Section, Task>(tableView: projectListView.fetchTableView(), cellProvider: { tableView, _, task  in
            let cell = tableView.dequeueReusableCell(withIdentifier: TaskCell.cellIdentifier) as? TaskCell
            cell?.configureData(task: task)
            return cell
        })
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private let projectListView: ProjectListView = {
        let view = ProjectListView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func loadView() {
        super.loadView()
        view = projectListView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        projectListView.setHeaderText(text: type.rawValue)
        projectListView.setHeaderItemCount(count: 0)
        projectListView.register(cellClass: TaskCell.self, forCellReuseIdentifier: TaskCell.cellIdentifier)
        configureDataSource()
    }

    private func configureDataSource() {
        projectListView.dataSource = dataSource
    }

    func applySnapShot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Task>()
        snapshot.appendSections([.main])
        snapshot.appendItems(filteredTasks)
        self.dataSource.apply(snapshot, animatingDifferences: true)
    }
}

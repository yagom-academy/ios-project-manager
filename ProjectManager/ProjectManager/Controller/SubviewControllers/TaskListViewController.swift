//
//  TodoViewController.swift
//  ProjectManager
//
//  Created by jin on 1/24/23.
//

import UIKit

class TaskListViewController: UIViewController {
    enum Section {
        case main
    }

    private var type: TaskStatus
    var filteredTasks: [Task] = [] {
        didSet {
            applySnapShot()
        }
    }
    var dataSource: UITableViewDiffableDataSource<Section, Task>

    private let projectListView: ProjectListView = {
        let view = ProjectListView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    init(type: TaskStatus) {
        self.type = type
        self.dataSource = UITableViewDiffableDataSource<Section, Task>(tableView: projectListView.fetchTableView(), cellProvider: { tableView, _, task  in
            let cell = tableView.dequeueReusableCell(withIdentifier: TaskCell.cellIdentifier) as? TaskCell
            cell?.task = task
            return cell
        })
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        super.loadView()
        view = projectListView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        projectListView.delegate = self
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

extension TaskListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

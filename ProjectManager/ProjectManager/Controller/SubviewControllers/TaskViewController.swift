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
    var dataSource: UITableViewDiffableDataSource<Section, Task>?

    init(type: TaskStatus) {
        self.type = type
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
        dataSource = UITableViewDiffableDataSource<Section, Task>(tableView: projectListView.fetchTableView(), cellProvider: { tableView, indexPath, uuid  in
            let cell = tableView.dequeueReusableCell(withIdentifier: TaskCell.cellIdentifier)

            return cell
        })
        projectListView.dataSource = dataSource
    }
}

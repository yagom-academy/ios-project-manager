//
//  TodoViewController.swift
//  ProjectManager
//
//  Created by jin on 1/24/23.
//

import UIKit

protocol TaskMoveDelegate: AnyObject {
    func taskDidMoved(_ task: Task, from currentStatus: TaskStatus, to futureStatus: TaskStatus)
}

class TaskListViewController: UIViewController {
    enum Section {
        case main
    }

    private var type: TaskStatus
    var filteredTasks: [Task] = [] {
        didSet {
            applySnapShot()
            projectListView.setHeaderItemCount(count: filteredTasks.count)
        }
    }
    var dataSource: UITableViewDiffableDataSource<Section, Task>
    weak var delegate: TaskMoveDelegate?

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
        registerLongPressedObserver()
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
    
    func deleteTask(_ task: Task) {
        if let index = filteredTasks.firstIndex(of: task) {
            filteredTasks.remove(at: index)
        }
    }
    
    private func showEditProjectView() {
        let addProjectViewController = EditProjectViewController(type: type)
        let secondNavigationController = UINavigationController(rootViewController: addProjectViewController)
        secondNavigationController.modalPresentationStyle = .formSheet
        self.present(secondNavigationController, animated: true)
    }
}

extension TaskListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showEditProjectView()
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension TaskListViewController {
    private func registerLongPressedObserver() {
        NotificationCenter.default.addObserver(self,
                                       selector: #selector(showPopoverMenu),
                                       name: Notification.Name("cellLongPressed"),
                                       object: nil)
    }
    
    @objc private func showPopoverMenu(_ notification: Notification) {
        guard let task = notification.userInfo?["task"] as? Task else {
            return
        }
        let menuAlert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        menuAlert.modalPresentationStyle = .popover
        menuAlert.popoverPresentationController?.permittedArrowDirections = .up
        menuAlert.popoverPresentationController?.sourceView = notification.object as? UIView
        
        let actions = generateMovingActions(task: task)
        actions.forEach { action in
            menuAlert.addAction(action)
        }
        
        self.present(menuAlert, animated: true)
    }
    
    private func generateMovingActions(task: Task) -> [UIAlertAction] {
        let alertActions =  task.status.movingOption.map { optionTitle, movedState in
            UIAlertAction(title: optionTitle, style: .default) { _ in
                self.delegate?.taskDidMoved(task, from: task.status, to: movedState)
            }
        }
        
        return alertActions
    }
}

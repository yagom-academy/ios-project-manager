//
//  ProjectManager - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class MainViewController: UIViewController {
    private typealias DataSource = UITableViewDiffableDataSource<Int, Task>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<Int, Task>
    
    private let mainView = MainView()
    private var dataSources: [TaskType: DataSource] = [:]
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
}

// MARK: TableViewDelegate

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let taskInfo = makeTaskInfo(tableView: tableView, indexPath: indexPath)
        let detailView = DetailModalView(frame: view.bounds)
        let detailModalViewController = DetailModalViewController(modalView: detailView,
                                                                  taskInfo: taskInfo)
        detailModalViewController.delegate = self
        detailView.setButtonDelegate(detailModalViewController)
        detailModalViewController.modalPresentationStyle = .formSheet
        self.present(detailModalViewController, animated: true)
    }
    
    func tableView(
        _ tableView: UITableView,
        trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {
        return ContextualActionBuilder()
            .addAction(
                title: "Delete",
                backgroundColor: .systemPink,
                style: .destructive,
                action: {
                    guard let taskInfo = self.makeTaskInfo(tableView: tableView, indexPath: indexPath) else { return }
                    self.deleteData(taskInfo: taskInfo)
                })
            .build()
    }
    
}

// MARK: DetailViewControllerDelegate

extension MainViewController: DetailViewControllerDelegate {
    func addTask(_ task: Task) {
        addData(task: task, type: .todo)
        mainView.refreshCount()
    }
    
    func updateTask(by taskInfo: TaskInfo) {
        let dataSource = dataSources[taskInfo.type]
        if let snapshot = dataSource?.snapshot() {
            var copySnapshot = snapshot
            guard let beforeTask = dataSource?.itemIdentifier(for: taskInfo.indexPath) else { return }
            let task = taskInfo.task
            copySnapshot.insertItems([task], afterItem: beforeTask)
            copySnapshot.deleteItems([beforeTask])
            dataSource?.apply(copySnapshot)
        }
    }
}

// MARK: PopoverViewControllerDelegate

extension MainViewController: PopoverViewControllerDelegate {
    func move(from taskInfo: TaskInfo, to type: TaskType) {
        deleteData(taskInfo: taskInfo)
        addData(task: taskInfo.task, type: type)
        mainView.refreshCount()
    }
}

// MARK: SetUp

extension MainViewController {
    private func setUp() {
        setNavigationBar()
        setTableView()
    }
    
    private func setNavigationBar() {
        navigationItem.title = "Project Manager"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(addButtonClick(_:)) )
    }
}

// MARK: functions

extension MainViewController {
    @objc
    private func addButtonClick(_ sender: Any) {
        let detailView = DetailModalView(frame: view.bounds)
        let detailModalViewController = DetailModalViewController(modalView: detailView)
        
        detailModalViewController.delegate = self
        detailView.setButtonDelegate(detailModalViewController)
        detailModalViewController.modalPresentationStyle = .formSheet
        self.present(detailModalViewController, animated: true)
    }
    
    @objc
    private func longPressGesture(sender: UILongPressGestureRecognizer) {
        guard let tableView = sender.view as? UITableView else { return }
        guard let type = mainView.findTableViewType(tableView: tableView) else { return }
        let point = sender.location(in: self.mainView.retrieveTableView(taskType: type))
        if let indexPath = tableView.indexPathForRow(at: point) {
            if let task = dataSources[type]?.itemIdentifier(for: indexPath) {
                switch sender.state {
                case .began:
                    let taskInfo = TaskInfo(task: task, type: type, indexPath: indexPath)
                    makePopover(taskInfo: taskInfo, point: point)
                default:
                    return
                }
            }
        }
    }
    
    private func deleteData(taskInfo: TaskInfo) {
        let dataSource = dataSources[taskInfo.type]
        if let snapshot = dataSource?.snapshot() {
            var copySnapshot = snapshot
            guard let beforeTask = dataSource?.itemIdentifier(for: taskInfo.indexPath) else { return }
            copySnapshot.deleteItems([beforeTask])
            dataSource?.apply(copySnapshot)
        }
    }
    
    private func addData(task: Task, type: TaskType) {
        let dataSource = dataSources[type]
        guard let snapshot = dataSource?.snapshot(), snapshot.numberOfSections > 0 else { return }
        var copySnapshot = snapshot
        copySnapshot.appendItems([task])
        dataSource?.apply(copySnapshot)
    }
    
    private func makePopover(taskInfo: TaskInfo, point: CGPoint) {
        let popoverController = PopoverViewController(taskInfo: taskInfo)
        popoverController.delegate = self
        popoverController.modalPresentationStyle = .popover
        popoverController.preferredContentSize = CGSize(width: 200, height: 100)
        
        let popover = popoverController.popoverPresentationController
        popover?.sourceView = mainView.retrieveTableView(taskType: taskInfo.type)
        popover?.sourceRect = CGRect(x: point.x, y: point.y, width: 0, height: 0)
        popover?.permittedArrowDirections = .up
        
        present(popoverController, animated: true)
    }
    
    private func makeTaskInfo(tableView: UITableView, indexPath: IndexPath) -> TaskInfo? {
        guard let type = mainView.findTableViewType(tableView: tableView) else { return nil }
        let dataSource = dataSources[type]
        guard let task = dataSource?.itemIdentifier(for: indexPath) else { return nil }
        let taskInfo = TaskInfo(task: task, type: type, indexPath: indexPath)
        
        return taskInfo
    }
}

// MARK: Setup ToDoTableView

extension MainViewController {
    private func setTableView() {
        setUpDataSource()
        TaskType.allCases.forEach { setUpTableView(type: $0) }
    }
    
    private func setUpDataSource() {
        TaskType.allCases.forEach { taskType in
            dataSources[taskType] = makeDataSource(type: taskType)
        }
    }
    
    private func setUpTableView(type: TaskType) {
        let tableView = mainView.retrieveTableView(taskType: type)
        tableView?.register(TaskCell.self, forCellReuseIdentifier: TaskCell.identifier)
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPressGesture(sender:)))
        tableView?.addGestureRecognizer(longPress)
        tableView?.dataSource = dataSources[type]
        tableView?.delegate = self
        tableView?.reloadData()
    }
    
    private func makeDataSource(type: TaskType) -> DataSource? {
        guard let tableView = mainView.retrieveTableView(taskType: type) else { return nil }
        let dataSource = DataSource(tableView: tableView, cellProvider: { tableView, indexPath, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: TaskCell.identifier,
                                                     for: indexPath) as? TaskCell
            cell?.setUpLabel(task: item)
            return cell
        })
        var snapshot = Snapshot()
        snapshot.appendSections([0])
        dataSource.apply(snapshot)
        return dataSource
    }
}

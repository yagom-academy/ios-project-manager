//
//  ProjectManager - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit
import FirebaseDatabase
import FirebaseDatabaseSwift

class MainViewController: UIViewController {
    private typealias DataSource = UITableViewDiffableDataSource<Int, Task>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<Int, Task>
    
    private let mainView = MainView()
    private var dataSources: [TaskType: DataSource] = [:]
    private var historys: [History] = []
    
    private var navigationHistoryButton: UIBarButtonItem?
    private var navigationAddButton: UIBarButtonItem?
    private var navigationSyncButton: UIBarButtonItem?
        
    private let taskManager = try? TaskManager()
    
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
                    self.deleteTask(taskInfo: taskInfo)
                })
            .build()
    }
    
}

// MARK: DetailViewControllerDelegate

extension MainViewController: DetailViewControllerDelegate {
    func addTask(_ task: Task) {
        addCell(task: task, type: .todo)
        try? taskManager?.create(task: task)
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
            try? taskManager?.update(task: task)
        }
    }
}

// MARK: PopoverViewControllerDelegate

extension MainViewController: PopoverViewControllerDelegate {
    func move(from taskInfo: TaskInfo, to type: TaskType) {
        addCell(task: taskInfo.task, type: type)
        deleteCell(taskInfo: taskInfo)
        mainView.refreshCount()
        
        let task = taskInfo.task
        let updatedTask = Task(id: task.id, title: task.title, date: task.date, body: task.body, type: type)
        try? taskManager?.update(task: updatedTask)
    }
}

// MARK: SetUp

extension MainViewController {
    private func setUp() {
        setNavigationBar()
        setTableView()
        mainView.refreshCount()
        taskManager?.setNetworkConnectionDelegate(delegate: self)
        taskManager?.setFirebaseEventObserveDelegate(delegate: self)
    }
    
    private func setNavigationBar() {
        let navigationHistoryButton = UIBarButtonItem(title: "History",
                                                              style: .plain,
                                                              target: self,
                                                              action: #selector(historyButtonClick(_:)))
        let navigationAddButton = UIBarButtonItem(barButtonSystemItem: .add,
                                                          target: self,
                                                          action: #selector(addButtonClick(_:)) )
        let navigationSyncButton = UIBarButtonItem(image: UIImage(systemName: "icloud.and.arrow.down.fill"),
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(syncButtonClick(_:)))
        self.navigationHistoryButton = navigationHistoryButton
        self.navigationAddButton = navigationAddButton
        self.navigationSyncButton = navigationSyncButton
        navigationItem.title = "Project Manager"
        navigationItem.rightBarButtonItem = navigationAddButton
        navigationItem.leftBarButtonItems = [navigationSyncButton, navigationHistoryButton]
    }
}

// MARK: functions

extension MainViewController {
    @objc
    private func historyButtonClick(_ sender: Any) {
        makePopover()
    }
    
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
    private func syncButtonClick(_ sender: Any) {
        try? taskManager?.sync { [weak self] in
            self?.setUpDataSource()
            self?.mainView.refreshCount()
        }
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
    
    private func deleteTask(taskInfo: TaskInfo) {
        deleteCell(taskInfo: taskInfo)
        try? taskManager?.delete(task: taskInfo.task)
        mainView.refreshCount()
    }
    
    private func deleteCell(taskInfo: TaskInfo) {
        let dataSource = dataSources[taskInfo.type]
        if let snapshot = dataSource?.snapshot() {
            var copySnapshot = snapshot
            guard let beforeTask = dataSource?.itemIdentifier(for: taskInfo.indexPath) else { return }
            copySnapshot.deleteItems([beforeTask])
            dataSource?.apply(copySnapshot)
        }
    }
    
    private func addCell(task: Task, type: TaskType) {
        let dataSource = dataSources[type]
        guard let snapshot = dataSource?.snapshot(), snapshot.numberOfSections > 0 else { return }
        var copySnapshot = snapshot
        copySnapshot.appendItems([task])
        dataSource?.apply(copySnapshot)
    }
    
    private func makePopover(taskInfo: TaskInfo, point: CGPoint) {
        let popoverController = MovingPopOverViewController(taskInfo: taskInfo)
        popoverController.delegate = self
        popoverController.modalPresentationStyle = .popover
        popoverController.preferredContentSize = CGSize(width: 200, height: 100)
        
        let popover = popoverController.popoverPresentationController
        popover?.sourceView = mainView.retrieveTableView(taskType: taskInfo.type)
        popover?.sourceRect = CGRect(x: point.x, y: point.y, width: 0, height: 0)
        popover?.permittedArrowDirections = .up
        
        present(popoverController, animated: true)
    }
    
    private func makePopover() {
        let popoverController = HistoryPopOverViewController(historys: historys)
        popoverController.modalPresentationStyle = .popover
        popoverController.preferredContentSize = CGSize(width: 500, height: 500)
        
        let popover = popoverController.popoverPresentationController
        popover?.barButtonItem = navigationHistoryButton
        popover?.permittedArrowDirections = .down
        
        present(popoverController, animated: true)
    }
    
    private func makeTaskInfo(tableView: UITableView, indexPath: IndexPath) -> TaskInfo? {
        guard let type = mainView.findTableViewType(tableView: tableView) else { return nil }
        let dataSource = dataSources[type]
        guard let task = dataSource?.itemIdentifier(for: indexPath) else { return nil }
        let taskInfo = TaskInfo(task: task, type: type, indexPath: indexPath)
        
        return taskInfo
    }
    
    private func findIndexPath(type: TaskType, id: String) -> IndexPath? {
        guard let elements = dataSources[type]?.accessibilityElements else { return nil }
        guard let task = elements.filter({ data in
            guard let task = data as? Task else { return false }
            return task.id == id
        }).first as? Task else {return nil}
        
        return dataSources[type]?.indexPath(for: task)
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
        guard let snapshot = makeSnapshot(type: type) else { return nil }
        
        dataSource.apply(snapshot)
        return dataSource
    }
    
    private func makeSnapshot(type: TaskType) -> Snapshot? {
        var snapshot = Snapshot()
        guard let tasks = taskManager?.read(type: type) else { return nil }
        
        snapshot.appendSections([0])
        snapshot.appendItems(tasks)
        
        return snapshot
    }
}

// MARK: NetworkConnectionDelegate

extension MainViewController: NetworkConnectionDelegate {
    func offline() {
        DispatchQueue.main.async {
            self.navigationSyncButton?.isEnabled = false
        }
    }
    
    func online() {
        DispatchQueue.main.async {
            self.navigationSyncButton?.isEnabled = true
        }
    }
}

// MARK: FirebaseEventObserveDelegate

extension MainViewController: FirebaseEventObserveDelegate {
    func added(snapshot: DataSnapshot) {
        guard let task = try? snapshot.data(as: Task.self) else { return }
        
        //addTask(task)
    }
    
    func changed(snapshot: DataSnapshot) {
        guard let task = try? snapshot.data(as: Task.self) else { return }
        
        guard let typeString = task.type,
              let tasktype = TaskType(rawValue: typeString),
              let indexPath = findIndexPath(type: tasktype, id: task.id) else { return }
        
        // indexPath 문제
        updateTask(by: TaskInfo(task: task, type: tasktype, indexPath: indexPath))
    }
    
    func removed(snapshot: DataSnapshot) {
        guard let task = try? snapshot.data(as: Task.self) else { return }
        
        guard let typeString = task.type,
              let tasktype = TaskType(rawValue: typeString),
              let indexPath = dataSources[tasktype]?.indexPath(for: task) else { return }
        
        deleteTask(taskInfo: TaskInfo(task: task, type: tasktype, indexPath: indexPath))
    }
}

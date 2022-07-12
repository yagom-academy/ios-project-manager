//
//  ProjectManager - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

struct TaskInfo {
    let task: Task
    let type: TaskType
    let indexPath: IndexPath
}

class MainViewController: UIViewController {
    private typealias TableViewDataSource = UITableViewDiffableDataSource<Int, Task>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<Int, Task>
    
    private lazy var mainView = MainView()
    private var todoDataSource: TableViewDataSource?
    private var doingDataSource: TableViewDataSource?
    private var doneDataSource: TableViewDataSource?
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
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
}

// MARK: TableViewDelegate

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let tableType = mainView.findTableViewType(tableView: tableView) else {
            return
        }
        let dataSource = findDataSource(type: tableType)
        guard let task = dataSource?.itemIdentifier(for: indexPath) else { return }
        let detailView = DetailModalView(frame: view.bounds)
        let taskInfo = TaskInfo(task: task, type: tableType, indexPath: indexPath)
        let detailModalViewController = DetailModalViewController(modalView: detailView,
                                                                  taskInfo: taskInfo)
        detailModalViewController.delegate = self
        detailView.setButtonDelegate(detailModalViewController)
        detailModalViewController.modalPresentationStyle = .formSheet
        self.present(detailModalViewController, animated: true)
    }
}

// MARK: DetailViewControllerDelegate

extension MainViewController: DetailViewControllerDelegate {
    func addTask(_ task: Task) {
        if let snapshot = todoDataSource?.snapshot(), snapshot.numberOfSections > 0 {
            var copySnapshot = snapshot
            copySnapshot.appendItems([task])
            todoDataSource?.apply(copySnapshot)
        } else {
            var snapshot = Snapshot()
            snapshot.appendSections([0])
            snapshot.appendItems([task])
            todoDataSource?.apply(snapshot)
        }
    }
    
    func updateTask(by taskInfo: TaskInfo) {
        let dataSource = findDataSource(type: taskInfo.type)
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
    func moveToToDo(taskInfo: TaskInfo) {
        deleteData(taskInfo: taskInfo)
        addData(task: taskInfo.task, type: .todo)
    }
    
    func moveToDoing(taskInfo: TaskInfo) {
        deleteData(taskInfo: taskInfo)
        addData(task: taskInfo.task, type: .doing)
    }
    
    func moveToDone(taskInfo: TaskInfo) {
        deleteData(taskInfo: taskInfo)
        addData(task: taskInfo.task, type: .done)
    }
    
    func deleteData(taskInfo: TaskInfo) {
        let dataSource = findDataSource(type: taskInfo.type)
        if let snapshot = dataSource?.snapshot() {
            var copySnapshot = snapshot
            guard let beforeTask = dataSource?.itemIdentifier(for: taskInfo.indexPath) else { return }
            copySnapshot.deleteItems([beforeTask])
            dataSource?.apply(copySnapshot)
        }
    }
    
    func addData(task: Task, type: TaskType) {
        let dataSource = findDataSource(type: type)
        if let snapshot = dataSource?.snapshot(), snapshot.numberOfSections > 0 {
            var copySnapshot = snapshot
            copySnapshot.appendItems([task])
            dataSource?.apply(copySnapshot)
        } else {
            var snapshot = Snapshot()
            snapshot.appendSections([0])
            snapshot.appendItems([task])
            dataSource?.apply(snapshot)
        }
    }
    
}

// MARK: SetUp

extension MainViewController {
    
    private func setUp() {
        setNavigationBar()
        setToDoTableView()
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
    func longPressGesture(sender: UILongPressGestureRecognizer) {
        guard let tableView = sender.view as? UITableView else { return }
        guard let tableViewType = mainView.findTableViewType(tableView: tableView) else { return }
        let point = sender.location(in: self.mainView.retrieveTableView(taskType: tableViewType))
        if let indexPath = tableView.indexPathForRow(at: point) {
            if let task = findDataSource(type: tableViewType)?.itemIdentifier(for: indexPath) {
                switch sender.state {
                case .began:
                    let taskInfo = TaskInfo(task: task, type: tableViewType, indexPath: indexPath)
                    makePopover(taskInfo: taskInfo, point: point)
                default:
                    return
                }
            }
        }
    }
    
    func makePopover(taskInfo: TaskInfo, point: CGPoint) {
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
}

// MARK: Setup ToDoTableView

extension MainViewController {
    private func setToDoTableView() {
        let todoTableView = mainView.retrieveTableView(taskType: .todo)
        let doingTableView = mainView.retrieveTableView(taskType: .doing)
        let doneTableView = mainView.retrieveTableView(taskType: .done)
        
        todoTableView.register(TaskCell.self, forCellReuseIdentifier: TaskCell.identifier)
        doingTableView.register(TaskCell.self, forCellReuseIdentifier: TaskCell.identifier)
        doneTableView.register(TaskCell.self, forCellReuseIdentifier: TaskCell.identifier)
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPressGesture(sender:)))
        todoTableView.addGestureRecognizer(longPress)
    
        makeToDoDataSource()
        
        todoTableView.dataSource = todoDataSource
        todoTableView.delegate = self
        todoTableView.reloadData()
        
        doingTableView.dataSource = doingDataSource
        doingTableView.delegate = self
        doingTableView.reloadData()
        
        doneTableView.dataSource = doneDataSource
        doneTableView.delegate = self
        doneTableView.reloadData()
    }
    
    private func makeToDoDataSource() {
        todoDataSource = TableViewDataSource(tableView: mainView.retrieveTableView(taskType: .todo),
                                                 cellProvider: { tableView, indexPath, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: TaskCell.identifier,
                                                     for: indexPath) as? TaskCell
            
            cell?.setUpLabel(task: item)
            return cell
        })
        
        doingDataSource = TableViewDataSource(tableView: mainView.retrieveTableView(taskType: .doing), cellProvider: { tableView, indexPath, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: TaskCell.identifier,
                                                     for: indexPath) as? TaskCell
            
            cell?.setUpLabel(task: item)
            return cell
        })
        
        doneDataSource = TableViewDataSource(tableView: mainView.retrieveTableView(taskType: .done), cellProvider: { tableView, indexPath, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: TaskCell.identifier,
                                                     for: indexPath) as? TaskCell
            
            cell?.setUpLabel(task: item)
            return cell
        })
        
    }
    
    private func findDataSource(type: TaskType?) -> TableViewDataSource? {
        switch type {
        case .todo:
            return todoDataSource
        case .doing:
            return doingDataSource
        case .done:
            return doneDataSource
        case .none:
            return nil
        }
    }
}

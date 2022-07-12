//
//  ProjectManager - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

struct LocationInfo {
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
        let task = dataSource?.itemIdentifier(for: indexPath)
        let detailView = DetailModalView(frame: view.bounds)
        let locationInfo = LocationInfo(type: tableType, indexPath: indexPath)
        let detailModalViewController = DetailModalViewController(modalView: detailView,
                                                                  task: task,
                                                                  locationInfo: locationInfo)
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
    
    func editTask(task: Task, locationInfo: LocationInfo) {
        let dataSource = findDataSource(type: locationInfo.type)
        if let snapshot = dataSource?.snapshot() {
            var copySnapshot = snapshot
            guard let beforeTask = dataSource?.itemIdentifier(for: locationInfo.indexPath) else { return }
            copySnapshot.insertItems([task], afterItem: beforeTask)
            copySnapshot.deleteItems([beforeTask])
            dataSource?.apply(copySnapshot)
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
            if let cell = tableView.cellForRow(at: indexPath) {
                switch sender.state {
                case .began:
                    makePopover(taskType: tableViewType)
                    print("")
                default:
                    print("")
                }
            }
        }
    }
    
    func makePopover(taskType: TaskType) {
    }
}

// MARK: Setup ToDoTableView

extension MainViewController {
    private func setToDoTableView() {
        let todoTableView = mainView.retrieveTableView(taskType: .todo)
        todoTableView.register(TaskCell.self, forCellReuseIdentifier: TaskCell.identifier)
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPressGesture(sender:)))
        todoTableView.addGestureRecognizer(longPress)
    
        makeToDoDataSource()
        todoTableView.dataSource = todoDataSource
        todoTableView.delegate = self
        todoTableView.reloadData()
    }
    
    private func makeToDoDataSource() {
        todoDataSource = TableViewDataSource(tableView: mainView.retrieveTableView(taskType: .todo),
                                                 cellProvider: { tableView, indexPath, item in
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

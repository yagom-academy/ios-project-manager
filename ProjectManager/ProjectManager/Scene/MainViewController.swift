//
//  ProjectManager - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

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
        let tableType = mainView.findTableViewType(tableView: tableView)
        let dataSource = getDataSource(type: tableType)
        let task = dataSource?.itemIdentifier(for: indexPath)
        let detailView = DetailModalView(frame: view.bounds)
        let detailModalViewController = DetailModalViewController(modalView: detailView, task: task)
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

// MARK: Setup ToDoTableView

extension MainViewController {
    private func setToDoTableView() {
        let todoTableView = mainView.retrieveTableView(taskType: .todo)
        todoTableView.register(TaskCell.self, forCellReuseIdentifier: TaskCell.identifier)
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
    
    private func getDataSource(type: TaskType?) -> TableViewDataSource? {
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

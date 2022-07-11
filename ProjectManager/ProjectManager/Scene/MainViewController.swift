//
//  ProjectManager - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class MainViewController: UIViewController {
    private typealias ToDoTableViewDataSource = UITableViewDiffableDataSource<Int, Task>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<Int, Task>
    
    private lazy var mainView = MainView()
    private var todoDataSource: ToDoTableViewDataSource?
    private var todoTasks = [Task]() {
        didSet {
            applySnapshot()
        }
    }
    
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

// MARK: DetailViewControllerDelegate

extension MainViewController: DetailViewControllerDelegate {
    func taskUpdate(task: Task) {
        todoTasks.append(task)
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
        let todoTableView = mainView.retrieveTableView(taskCase: .todo)
        todoTableView.register(TaskCell.self, forCellReuseIdentifier: TaskCell.identifier)
        makeToDoDataSource()
        todoTableView.dataSource = todoDataSource
        todoTableView.reloadData()
    }
    
    private func makeToDoDataSource() {
        todoDataSource = ToDoTableViewDataSource(tableView: mainView.retrieveTableView(taskCase: .todo),
                                                 cellProvider: { tableView, indexPath, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: TaskCell.identifier,
                                                     for: indexPath) as? TaskCell
            
            cell?.setUpLabel(task: item)
            return cell
        })
    }
    
    private func applySnapshot() {
        var snapshot = Snapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(todoTasks)
        
        todoDataSource?.apply(snapshot)
    }
    
}

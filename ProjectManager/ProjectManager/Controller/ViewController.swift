//
//  ProjectManager - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var todoTableView: UITableView!
    @IBOutlet weak var doingTableView: UITableView!
    @IBOutlet weak var doneTableView: UITableView!
    @IBOutlet weak var todoHeaderView: CustomTableHeader!
    @IBOutlet weak var doingHeaderView: CustomTableHeader!
    @IBOutlet weak var doneHeaderView: CustomTableHeader!
    
    let dataSourceVM = DataSourceViewModel()
    let taskListVM = TaskListViewModel()
    
    private lazy var todoDataSource = dataSourceVM.makeDataSource(tableView: todoTableView, taskListVM.todoTasks)
    private lazy var doingDataSource = dataSourceVM.makeDataSource(tableView: doingTableView, taskListVM.doingTasks)
    private lazy var doneDataSource = dataSourceVM.makeDataSource(tableView: doneTableView, taskListVM.doneTasks)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSuperViewColor()
        setTableHeaderLabel()
        todoTableView.dataSource = todoDataSource
        doingTableView.dataSource = doingDataSource
        doneTableView.dataSource = doneDataSource
        todoTableView.delegate = self
        doingTableView.delegate = self
        doneTableView.delegate = self
        reloadTasksTableViewDataSource()
    }
    
    @IBAction func tapAdd(_ sender: UIBarButtonItem) {
        let addViewController = storyboard?.instantiateViewController(identifier: "addViewController") as? AddViewController ?? AddViewController()
        addViewController.setUpTaskListVM(taskListVM)
        addViewController.modalPresentationStyle = .formSheet
        present(addViewController, animated: true)
    }
    
    private func reloadTasksTableViewDataSource() {
        taskListVM.reloadTodoTasks = { [weak self] tasks in
            guard let self = self else { return }
            self.update(dataSource: self.todoDataSource, tasksStatus: tasks)
        }
        taskListVM.reloadDoingTasks = { [weak self] tasks in
            guard let self = self else { return }
            self.update(dataSource: self.doingDataSource, tasksStatus: tasks)
        }
        taskListVM.reloadDoneTasks = { [weak self] tasks in
            guard let self = self else { return }
            self.update(dataSource: self.doneDataSource, tasksStatus: tasks)
        }
    }
    
    private func update(dataSource: UITableViewDiffableDataSource<Section, Task>, tasksStatus: [Task]) {
        var snapShot = NSDiffableDataSourceSnapshot<Section, Task>()
        snapShot.appendSections([.main])
        snapShot.appendItems(tasksStatus)
        dataSource.apply(snapShot, animatingDifferences: true)
    }
    
    private func setupSuperViewColor() {
        view.backgroundColor = UIColor(red: 0.969, green: 0.969, blue: 0.969, alpha: 1)
    }
    
    private func setTableHeaderLabel() {
        todoHeaderView.setTaskCountLabel(taskListVM, status: .todo)
        doingHeaderView.setTaskCountLabel(taskListVM, status: .doing)
        doneHeaderView.setTaskCountLabel(taskListVM, status: .done)
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let editViewController = storyboard?.instantiateViewController(withIdentifier: "editViewController") as? EditViewController ?? EditViewController()
        sendDelegateInfo(editViewController, tableView, indexPath)
        editViewController.setUpTaskListVM(taskListVM)
        editViewController.modalPresentationStyle = .formSheet
        present(editViewController, animated: true)
    }
    
    private func sendDelegateInfo(_ editViewController: EditViewController,
                                  _ tableView: UITableView,
                                  _ indexPath: IndexPath ) {
        switch tableView {
        case todoTableView:
            let info = DelegateInfo(status: .todo, indexPathRow: indexPath.row)
            editViewController.setUpDelegateInfo(info: info)
        case doingTableView:
            let info = DelegateInfo(status: .doing, indexPathRow: indexPath.row)
            editViewController.setUpDelegateInfo(info: info)
        case doneTableView:
            let info = DelegateInfo(status: .done, indexPathRow: indexPath.row)
            editViewController.setUpDelegateInfo(info: info)
        default:
            break
        }
    }
    
}

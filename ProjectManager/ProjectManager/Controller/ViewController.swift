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
    
    let dataSourceVM = DataSourceViewModel()
    let taskListVM = TaskListViewModel()
    
    private lazy var todoDataSource = dataSourceVM.makeDataSource(tableView: todoTableView, taskListVM.todoTasks)
    private lazy var doingDataSource = dataSourceVM.makeDataSource(tableView: doingTableView, taskListVM.doingTasks)
    private lazy var doneDataSource = dataSourceVM.makeDataSource(tableView: doneTableView, taskListVM.doneTasks)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        todoTableView.dataSource = todoDataSource
        doingTableView.dataSource = doingDataSource
        doneTableView.dataSource = doneDataSource
        taskListVM.reloadTodoTasks = { [weak self] in
            self?.update()
        }
    }
    
    @IBAction func tapAdd(_ sender: UIBarButtonItem) {
        let addViewController = storyboard?.instantiateViewController(identifier: "addViewController") as? AddViewController ?? AddViewController()
        addViewController.setUpTaskListVM(taskListVM)
        addViewController.modalPresentationStyle = .formSheet
        present(addViewController, animated: true)
    }
    
    func update() {
        var snapShot = NSDiffableDataSourceSnapshot<Section, Task>()
        snapShot.appendSections([.main])
        snapShot.appendItems(taskListVM.todoTasks)
        todoDataSource.apply(snapShot, animatingDifferences: true)
    }
}

/*
 1. didSet을 활용해서 TaskListViewModel의 todoTasks의 값이 변경(추가)되었을 때,
 2. diffableDataSource의 snapShot을 업데이트 하라고 코드를 짰습니당.
 3. 하지만, index오류가 발생함. (원인: diffableDataSource는 taskListViewModel의 todoTasks의 새로 추가되어있는 index를 갖고있지 않더라구요 -lldb로 확인)
 4. taskListViewModel의 todoTasks는 변경된 데이터의 새로 추가된 index를 갖고 있는 상황입니다.
 5. 왜 diffableDataSource의 viewModel에서만 추가된 인덱스를 갖지 못하는 것일까요 ??
 */

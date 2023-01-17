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
    }
    
    @IBAction func tapAdd(_ sender: UIBarButtonItem) {
        let addViewController = storyboard?.instantiateViewController(identifier: "addViewController") as? AddViewController ?? AddViewController()
        addViewController.modalPresentationStyle = .formSheet
        present(addViewController, animated: true)
    }
}

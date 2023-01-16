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
    let taskListVM = TaskListViewModel(tasks: [Task(title: "안녕", description: "이거되니?", date: Date())])
    
    private lazy var todoDataSource = dataSourceVM.makeDataSource(tableView: todoTableView, taskListVM)
    private lazy var doingDataSource = dataSourceVM.makeDataSource(tableView: doingTableView, taskListVM)
    private lazy var doneDataSource = dataSourceVM.makeDataSource(tableView: doneTableView, taskListVM)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        todoTableView.dataSource = todoDataSource
        doingTableView.dataSource = doingDataSource
        doneTableView.dataSource = doneDataSource
    }
}

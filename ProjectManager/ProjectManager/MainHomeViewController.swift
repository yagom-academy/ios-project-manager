//
//  ProjectManager - MainHomeViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class MainHomeViewController: UIViewController {

    @IBOutlet weak var doingTableView: UITableView!
    @IBOutlet weak var todoTableView: UITableView!
    @IBOutlet weak var doneTableView: UITableView!

    @IBOutlet weak var todoCount: UIButton!
    @IBOutlet weak var doingCount: UIButton!
    @IBOutlet weak var doneCount: UIButton!

    private let databaseManager: DatabaseManager = RealmDatabaseManager()
    private var todoList = [TaskModel]()
    private var doingList = [TaskModel]()
    private var doneList = [TaskModel]()

    override func viewDidLoad() {
        super.viewDidLoad()

        let value = UIInterfaceOrientation.landscapeLeft.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")

        setUpDataList()

        todoCount.setTitle(String(todoList.count), for: .normal)
        doingCount.setTitle(String(doingList.count), for: .normal)
        doneCount.setTitle(String(doneList.count), for: .normal)

        todoTableView.dataSource = self
        todoTableView.delegate = self

        doingTableView.dataSource = self
        doingTableView.delegate = self

        doneTableView.dataSource = self
        doneTableView.delegate = self
    }

    private func setUpDataList() {
        let allDatabase = databaseManager.readDatabase()

        allDatabase.forEach { task in
            if task.taskState == TaskState.todo {
                todoList.append(task)
            } else if task.taskState == TaskState.doing {
                doingList.append(task)
            } else {
                doneList.append(task)
            }
        }
    }
}

extension MainHomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == todoTableView {
            return databaseManager.getTaskStateCount(state: TaskState.todo)
        } else if tableView == doingTableView {
            return databaseManager.getTaskStateCount(state: TaskState.doing)
        } else {
            return databaseManager.getTaskStateCount(state: TaskState.done)
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if tableView == todoTableView {
            let cell = todoTableView.dequeueReusableCell(withIdentifier: "todoTableViewCell", for: indexPath) as! TableViewCell
            let data = todoList[indexPath.row]
            cell.titleLabel.text = data.taskTitle
            cell.descriptionLabel.text = data.taskDescription
            cell.deadlineLabel.text = data.taskDeadline
            return cell
        } else if tableView == doingTableView {
            let cell = todoTableView.dequeueReusableCell(withIdentifier: "todoTableViewCell", for: indexPath) as! TableViewCell
            let data = doingList[indexPath.row]
            cell.titleLabel.text = data.taskTitle
            cell.descriptionLabel.text = data.taskDescription
            cell.deadlineLabel.text = data.taskDeadline
            return cell
        } else {
            let cell = todoTableView.dequeueReusableCell(withIdentifier: "todoTableViewCell", for: indexPath) as! TableViewCell
            let data = doneList[indexPath.row]
            cell.titleLabel.text = data.taskTitle
            cell.descriptionLabel.text = data.taskDescription
            cell.deadlineLabel.text = data.taskDeadline
            return cell
        }
    }
}

//
//  ProjectManager - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit
import SnapKit

final class MainViewController: UIViewController {
    
    private var todos: [Task] = [] {
        didSet {
            mainView.setTaskCount(to: todos.count, taskType: .todo)
        }
    }
    private var doings: [Task] = [] {
        didSet {
            mainView.setTaskCount(to: doings.count, taskType: .doing)
        }
    }
    private var dones: [Task] = [] {
        didSet {
            mainView.setTaskCount(to: dones.count, taskType: .done)
        }
    }
    
    private let mainView = MainView()
    
    override func loadView() {
        super.loadView()
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationItems()
        registerTableViewInfo()
        fetchData()
        mainView.setupSubViews()
        mainView.setupUILayout()
    }
    
    private func configureNavigationItems() {
        title = "Project Manager"
        let plusButton = UIBarButtonItem(
            image: UIImage(
                systemName: "plus"
            ),
            style: .plain,
            target: self,
            action: #selector(showNewFormSheetView)
        )
        navigationItem.rightBarButtonItem = plusButton
    }
    
    private func registerTableViewInfo() {
        mainView.todoTableView.delegate = self
        mainView.todoTableView.dataSource = self
        mainView.todoTableView.register(
            TaskTableViewCell.self,
            forCellReuseIdentifier: TaskTableViewCell.identifier
        )
        mainView.doingTableView.delegate = self
        mainView.doingTableView.dataSource = self
        mainView.doingTableView.register(
            TaskTableViewCell.self,
            forCellReuseIdentifier: TaskTableViewCell.identifier
        )
        mainView.doneTableView.delegate = self
        mainView.doneTableView.dataSource = self
        mainView.doneTableView.register(
            TaskTableViewCell.self,
            forCellReuseIdentifier: TaskTableViewCell.identifier
        )
    }
    
    private func fetchData() {
        fetchToDo()
        fetchDoing()
        fetchDone()
    }
    
    private func fetchToDo() {
        todos = [
            Task(title: "타이틀1", description: "1", date: "1"),
            Task(title: "타이틀1", description: "1", date: "1"),
            Task(title: "타이틀1", description: "1", date: "1"),
            Task(title: "타이틀1", description: "1", date: "1"),
            Task(title: "타이틀1", description: "1", date: "1"),
            Task(title: "타이틀1", description: "1", date: "1"),
            Task(title: "타이틀1", description: "1", date: "1"),
            Task(title: "타이틀1", description: "1", date: "1"),
            Task(title: "타이틀1", description: "1", date: "1"),
            Task(title: "타이틀1", description: "1", date: "1"),
            Task(title: "타이틀1", description: "1", date: "1"),
            Task(title: "타이틀1", description: "1", date: "1")
        ]
    }
    
    private func fetchDoing() {
        doings = [
            Task(title: "타이틀2", description: "2", date: "2"),
            Task(title: "타이틀2", description: "2", date: "2"),
            Task(title: "타이틀2", description: "2", date: "2"),
            Task(title: "타이틀2", description: "2", date: "2"),
            Task(title: "타이틀2", description: "2", date: "2"),
            Task(title: "타이틀2", description: "2", date: "2"),
            Task(title: "타이틀2", description: "2", date: "2")
        ]
    }
    
    private func fetchDone() {
        dones = [
            Task(title: "타이틀3", description: "3", date: "3"),
            Task(title: "타이틀3", description: "3", date: "3")
        ]
    }
    
    @objc private func showNewFormSheetView() {
        let newTodoFormSheet = UINavigationController(
            rootViewController: NewFormSheetViewController()
        )
        newTodoFormSheet.modalPresentationStyle = .formSheet
        present(newTodoFormSheet, animated: true)
    }
}

// MARK: - TableView Method

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        if tableView == mainView.todoTableView {
            return todos.count
        } else if tableView == mainView.doingTableView {
            return doings.count
        } else {
            return dones.count
        }
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard let todoCell = mainView.todoTableView.dequeueReusableCell(
            withIdentifier: TaskTableViewCell.identifier,
            for: indexPath
        ) as? TaskTableViewCell else {
            return UITableViewCell()
        }
        todoCell.setupContents(task: todos[indexPath.row])
        return todoCell
    }
    
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        let editViewController = EditFormSheetViewController()
        editViewController.task = todos[indexPath.row]
        let editFormSheet = UINavigationController(
            rootViewController: editViewController
        )
        editFormSheet.modalPresentationStyle = .formSheet
        present(editFormSheet, animated: true)
    }
}

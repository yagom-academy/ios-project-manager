//
//  ProjectManager - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit
import SnapKit
import RxCocoa
import RxSwift

final class MainViewController: UIViewController {
    
    private var todos: [Work] = []
    private var doings: [Work] = []
    private var dones: [Work] = []
    
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
            action: #selector(showAddWindow)
        )
        navigationItem.rightBarButtonItem = plusButton
    }
    
    private func registerTableViewInfo() {
        mainView.todoTableView.delegate = self
        mainView.todoTableView.dataSource = self
        mainView.todoTableView.register(
            WorkTableViewCell.self,
            forCellReuseIdentifier: WorkTableViewCell.identifier
        )
        mainView.doingTableView.delegate = self
        mainView.doingTableView.dataSource = self
        mainView.doingTableView.register(
            WorkTableViewCell.self,
            forCellReuseIdentifier: WorkTableViewCell.identifier
        )
        mainView.doneTableView.delegate = self
        mainView.doneTableView.dataSource = self
        mainView.doneTableView.register(
            WorkTableViewCell.self,
            forCellReuseIdentifier: WorkTableViewCell.identifier
        )
    }
    
    private func fetchData() {
        fetchToDo()
        fetchDoing()
        fetchDone()
    }
    
    private func fetchToDo() {
        todos = [
            Work(title: "타이틀1", description: "1", date: "1"),
            Work(title: "타이틀1", description: "1", date: "1"),
            Work(title: "타이틀1", description: "1", date: "1"),
            Work(title: "타이틀1", description: "1", date: "1"),
            Work(title: "타이틀1", description: "1", date: "1"),
            Work(title: "타이틀1", description: "1", date: "1"),
            Work(title: "타이틀1", description: "1", date: "1"),
            Work(title: "타이틀1", description: "1", date: "1"),
            Work(title: "타이틀1", description: "1", date: "1"),
            Work(title: "타이틀1", description: "1", date: "1"),
            Work(title: "타이틀1", description: "1", date: "1"),
            Work(title: "타이틀1", description: "1", date: "1")
        ]
    }
    
    private func fetchDoing() {
        doings = [
            Work(title: "타이틀2", description: "2", date: "2"),
            Work(title: "타이틀2", description: "2", date: "2"),
            Work(title: "타이틀2", description: "2", date: "2"),
            Work(title: "타이틀2", description: "2", date: "2"),
            Work(title: "타이틀2", description: "2", date: "2"),
            Work(title: "타이틀2", description: "2", date: "2"),
            Work(title: "타이틀2", description: "2", date: "2")
        ]
    }
    
    private func fetchDone() {
        dones = [
            Work(title: "타이틀3", description: "3", date: "3"),
            Work(title: "타이틀3", description: "3", date: "3")
        ]
    }
    
    @objc private func showAddWindow() {
        let vc = UINavigationController(rootViewController: NewToDoViewController())
        vc.modalPresentationStyle = .formSheet
        present(vc, animated: true)
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
            withIdentifier: WorkTableViewCell.identifier,
            for: indexPath
        ) as? WorkTableViewCell else {
            return UITableViewCell()
        }
        
        todoCell.setupContents(data: todos[indexPath.row])
        
        return todoCell
    }
}

//
//  ProjectManager - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit
import SnapKit
import RxCocoa
import RxSwift

final class ViewController: UIViewController {
    
    private var todos: [Work] = []
    private let mainView = MainView()
    
    private lazy var baseStackView = UIStackView(
        arrangedSubviews: [
            todoTableView,
            doingTableView,
            doneTableView
        ]
    ).then {
        $0.axis = .horizontal
        $0.spacing = 15
        $0.distribution = .fillEqually
    }
    
    private lazy var todoTableView = UITableView()
    private lazy var doingTableView = UITableView()
    private lazy var doneTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = mainView
        
        
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
        
        mainView.todoTableView.delegate = self
        mainView.todoTableView.dataSource = self
        todoTableView.register(WorkTableViewCell.self, forCellReuseIdentifier: WorkTableViewCell.identifier)
        
        fetchToDo()
        mainView.setupSubViews()
        mainView.setupUILayout()
    }
    
    private func fetchToDo() {
        todos = [
            Work(title: "타이틀1", description: "1", date: "1"),
            Work(title: "타이틀1", description: "1", date: "1"),
            Work(title: "타이틀1", description: "1", date: "1"),
            Work(title: "타이틀1", description: "1", date: "1"),
            Work(title: "타이틀1", description: "1", date: "1")
        ]
    }
    
    @objc private func showAddWindow() {
        let vc = UINavigationController(rootViewController: NewToDoViewController())
        vc.modalPresentationStyle = .formSheet
        present(vc, animated: true)
    }
}

// MARK: - TableView Method
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return todos.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard let todoCell = todoTableView.dequeueReusableCell(
            withIdentifier: WorkTableViewCell.identifier,
            for: indexPath
        ) as? WorkTableViewCell else {
            return UITableViewCell()
        }
        
        todoCell.setupContents(data: todos[indexPath.row])
        
        return todoCell
    }
}

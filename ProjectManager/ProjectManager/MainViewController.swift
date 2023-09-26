//
//  ProjectManager - MainViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

final class MainViewController: UIViewController {
    let todoList: [String] = ["todo1", "todo2", "todo3", "todo4", "todo5"]
    let doingList: [String] = ["doing1", "doing2", "doing3", "doing4"]
    let doneList: [String] = ["done1", "done2", "done3", "done4", "done5", "done6"]
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    
    private let todoTableView: UITableView = {
        let tableView = UITableView()
        
        return tableView
    }()
    
    private let doingTableView: UITableView = {
        let tableView = UITableView()

        return tableView
    }()

    private let doneTableView: UITableView = {
        let tableView = UITableView()

        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTableViews()
        setUI()
    }
    
    private func setTableViews() {
        todoTableView.dataSource = self
        todoTableView.delegate = self
        todoTableView.register(ManagerCell.self, forCellReuseIdentifier: ManagerCell.identifier)
        
        doingTableView.dataSource = self
        doingTableView.delegate = self
        doingTableView.register(ManagerCell.self, forCellReuseIdentifier: ManagerCell.identifier)

        doneTableView.dataSource = self
        doneTableView.delegate = self
        doneTableView.register(ManagerCell.self, forCellReuseIdentifier: ManagerCell.identifier)
    }

    private func setUI() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(stackView)
        
        stackView.addArrangedSubview(todoTableView)
        stackView.addArrangedSubview(doingTableView)
        stackView.addArrangedSubview(doneTableView)
        
        stackView.backgroundColor = .systemGray4
        todoTableView.backgroundColor = .systemGray6
        doingTableView.backgroundColor = .systemGray6
        doneTableView.backgroundColor = .systemGray6
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == todoTableView {
            return todoList.count
        } else if tableView == doingTableView {
            return doingList.count
        } else {
            return doneList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ManagerCell.identifier, for: indexPath) as? ManagerCell else {
            return UITableViewCell()
        }
        
        if tableView == todoTableView {
            let title = "\(todoList[indexPath.row])의 제목"
            let description = "\(todoList[indexPath.row]) 의 내용입니다."
            cell.config(title: title, description: description, deadline: Date())
        } else if tableView == doingTableView {
            let title = "\(doneList[indexPath.row])의 제목"
            let description = "\(doneList[indexPath.row]) 의 내용입니다."
            cell.config(title: title, description: description, deadline: Date())
        } else {
            let title = "\(doneList[indexPath.row])의 제목"
            let description = "\(doneList[indexPath.row]) 의 내용입니다."
            cell.config(title: title, description: description, deadline: Date())
        }
        
        return cell
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

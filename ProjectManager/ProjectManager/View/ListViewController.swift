//
//  ProjectManager - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

final class ListViewController: UIViewController {
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .systemGray6
        tableView.register(ListCell.self, forCellReuseIdentifier: ListCell.identifier)
        tableView.separatorInset.left = .zero
        
        return tableView
    }()
    
    private let listViewModel = ListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        setUpViewDidLoadNotification()
        setUpBindings()
    }
    
    // viewDidLoad 시점을 뷰모델에 알려 데이터를 로드할 수 있도록 함
    private func setUpViewDidLoadNotification() {
        NotificationCenter.default
            .post(
                name: NSNotification.Name("ListViewControllerViewDidLoad"),
                object: nil
            )
    }
    
    // listViewModel의 todoList가 바뀌면 테이블뷰를 업데이트
    private func setUpBindings() {
        listViewModel.bindTodoList { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    @objc
    private func addTodo() {
        
    }
}

// MARK: - Configure UI
extension ListViewController {
    private func configureUI() {
        setUpView()
        setUpNavigation()
        addSubviews()
        setUpTableViewConstraints()
    }
    
    private func setUpView() {
        view.backgroundColor = .systemBackground
    }
    
    private func setUpNavigation() {
        navigationItem.title = "Project Manager"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "plus"),
            style: .plain,
            target: self,
            action: #selector(addTodo)
        )
    }
    
    private func addSubviews() {
        view.addSubview(tableView)
    }
    
    private func setUpTableViewConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor
                .constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor
                .constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.topAnchor
                .constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor
                .constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

// MARK: - Table View Data Source
extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return ListHeader(viewModel: listViewModel)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listViewModel.todoList?.count ?? .zero
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListCell.identifier) as? ListCell,
              let todoList = listViewModel.todoList,
              let todo = todoList[safe: indexPath.row]
        else {
            return UITableViewCell()
        }
        
        cell.setUpContent(todo)
        
        return cell
    }
}

// MARK: - Table View Delegate
extension ListViewController: UITableViewDelegate {
    
}

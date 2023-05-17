//
//  ProjectManager - TodoListViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

final class TodoListViewController: UIViewController {
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    
    private let todoListViewModel = TodoListViewModel()
    
    private let todoTableView = UITableView()
    private let doingTableView = UITableView()
    private let doneTableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
        setUpStackView()
        configureNavigationBar()
    }
    
    private func setUpView() {
        view.addSubview(stackView)
        view.backgroundColor = .white
        todoTableView.dataSource = self
    }
    
    private func setUpStackView() {
        stackView.addArrangedSubview(todoTableView)
        stackView.addArrangedSubview(doingTableView)
        stackView.addArrangedSubview(doneTableView)
        
        let safeArea = view.safeAreaLayoutGuide
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            stackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            stackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
        ])
    }
    
    private func configureNavigationBar() {
        let title = "Project Manager"
        let plusButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(plusButtonTapped))
        
        navigationItem.title = title
        navigationItem.rightBarButtonItem = plusButton
    }
    
    @objc func plusButtonTapped() {
        let plusTodoViewController = PlusTodoViewController()
        present(plusTodoViewController, animated: false)
    }
}

extension TodoListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoListViewModel.numberOfItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? TodoTableViewCell else { return UITableViewCell() }
        let item = todoListViewModel.item(at: indexPath.row)
        cell.configureCell(with: item)
        
        return cell
    }
}

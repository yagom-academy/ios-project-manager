//
//  ProjectManager - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class ListViewController: UIViewController {
    
    let viewModel = ListViewModel()
    
    lazy var todoListView = ListView(category: .todo)
    lazy var doingListView = ListView(category: .doing)
    lazy var doneListView = ListView(category: .done)
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .systemGray3
        stackView.alignment = .fill
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureTableVeiw()
        configureLayout()
        
    }
    
    private func configureLayout() {
        view.backgroundColor = .systemGray6
        view.addSubview(stackView)
        stackView.addArrangedSubview(todoListView)
        stackView.addArrangedSubview(doingListView)
        stackView.addArrangedSubview(doneListView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func configureTableVeiw() {
        [todoListView, doingListView, doneListView].forEach {
            $0.tableView.delegate = self
            $0.tableView.dataSource = self
        }
        
        viewModel.bind {
            [self.todoListView, self.doingListView, self.doneListView].forEach {
                $0.tableView.reloadData()
                $0.tableView.reloadData()
            }
        }
    }
    private func configureNavigationBar() {
        navigationItem.title = "Project Manager"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self, action: #selector(addTapped))
    }
    
    @objc func addTapped() {
        let addViewController = AddViewController()
        let navigationViewController = UINavigationController(rootViewController: addViewController)
        addViewController.delegate = self
        navigationViewController.modalPresentationStyle = UIModalPresentationStyle.formSheet
        
        present(navigationViewController, animated: true)
    }
    
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case doneListView.tableView:
            return viewModel.doneList.count
        case doingListView.tableView:
            return viewModel.doingList.count
        case todoListView.tableView:
            return viewModel.todoList.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListCell.identifier, for: indexPath)
                as? ListCell else { return ListCell() }
        
        switch tableView {
        case doneListView.tableView:
            cell.configureData(work: viewModel.doneList[indexPath.row])
        case doingListView.tableView:
            cell.configureData(work: viewModel.doingList[indexPath.row])
        case todoListView.tableView:
            cell.configureData(work: viewModel.todoList[indexPath.row])
        default:
            break
        }
        
        return cell
    }
}

extension ListViewController: WorkDelegate {
    func send(data: Work) {
        viewModel.updateWork(data: data)
    }
}

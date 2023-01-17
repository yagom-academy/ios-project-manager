//
//  ProjectManager - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class ListViewController: UIViewController {
    
    let viewModel = ListViewModel()
    
    let todoListView = ListView(category: .todo)
    let doingListView = ListView(category: .doing)
    let doneListView = ListView(category: .done)
    
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
        let addViewController = WorkFormViewController()
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
        cell.delegate = self
        
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
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        switch tableView {
        case doneListView.tableView:
            print("xnen2")
        case doingListView.tableView:
            print("xnen3")
        case todoListView.tableView:
            viewModel.deleteWork(data: viewModel.todoList[indexPath.row])
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let addViewController = WorkFormViewController()
        let navigationViewController = UINavigationController(rootViewController: addViewController)
        addViewController.work = viewModel.todoList[indexPath.row]
        addViewController.delegate = self
        navigationViewController.modalPresentationStyle = UIModalPresentationStyle.formSheet
        
        present(navigationViewController, animated: true)
    }
}

// Custom Delegate
extension ListViewController: WorkDelegate, CellDelegate {
    func showPopover(cell: ListCell) {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

       actionSheet.addAction(UIAlertAction(title: "Move to Doing", style: .default, handler: { _ in  }))
        
       actionSheet.addAction(UIAlertAction(title: "Move to Done", style: .default, handler: { _ in  }))
        
       actionSheet.popoverPresentationController?.sourceView = cell
       present(actionSheet, animated: true, completion: nil)
    }
    
    func send(data: Work) {
        viewModel.updateWork(data: data)
    }
    
}

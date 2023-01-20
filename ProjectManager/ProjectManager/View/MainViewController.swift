//
//  ProjectManager - MainViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

final class MainViewController: UIViewController {
    private let viewModel = MainViewModel()
    
    private let todoListView = ListView(viewModel: ListViewModel(category: .todo))
    private let doingListView = ListView(viewModel: ListViewModel(category: .doing))
    private let doneListView = ListView(viewModel: ListViewModel(category: .done))
    
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
        configureLayout()
        configureTableView()
        configureBind()
        configureData()
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
    
    private func configureTableView() {
        [todoListView, doingListView, doneListView].forEach {
            $0.tableView.delegate = self
            $0.tableView.dataSource = self
        }
    }
    
    private func configureBind() {
        viewModel.bindTodoList { [weak self] in
            self?.todoListView.didChangeCountValue(count: $0.count)
        }
        
        viewModel.bindDoingList { [weak self] in
            self?.doingListView.didChangeCountValue(count: $0.count)
        }
        
        viewModel.bindDoneList { [weak self] in
            self?.doneListView.didChangeCountValue(count: $0.count)
        }
    }
    
    private func configureNavigationBar() {
        navigationItem.title = "Project Manager"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self, action: #selector(addTapped))
    }
    
    private func configureData() {
        viewModel.load()
    }
    
    @objc private func addTapped() {
        let workFormViewController = WorkFormViewController()
        let navigationViewController = UINavigationController(rootViewController: workFormViewController)
        workFormViewController.delegate = self
        navigationViewController.modalPresentationStyle = UIModalPresentationStyle.formSheet
        
        present(navigationViewController, animated: true)
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
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
            viewModel.deleteWork(data: viewModel.doneList[indexPath.row])
        case doingListView.tableView:
            viewModel.deleteWork(data: viewModel.doingList[indexPath.row])
        case todoListView.tableView:
            viewModel.deleteWork(data: viewModel.todoList[indexPath.row])
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let workFormViewController = WorkFormViewController()
        let navigationViewController = UINavigationController(rootViewController: workFormViewController)
        
        switch tableView {
        case doneListView.tableView:
            workFormViewController.viewModel.work = viewModel.doneList[indexPath.row]
        case doingListView.tableView:
            workFormViewController.viewModel.work = viewModel.doingList[indexPath.row]
        case todoListView.tableView:
            workFormViewController.viewModel.work = viewModel.todoList[indexPath.row]
        default:
            break
        }
        
        workFormViewController.viewModel.isEdit = false
        workFormViewController.delegate = self
        navigationViewController.modalPresentationStyle = UIModalPresentationStyle.formSheet
        
        present(navigationViewController, animated: true)
    }
}

extension MainViewController: WorkFormDelegate, CellDelegate {
    func showPopover(soruceView: UIView?, work: Work?) {
        guard let work else { return }
        
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: work.category.otherDescription.0, style: .default, handler: { _ in
            self.viewModel.moveWork(data: work, category: work.category.other.0)
        }))
        
        actionSheet.addAction(UIAlertAction(title: work.category.otherDescription.1, style: .default, handler: { _ in
            self.viewModel.moveWork(data: work, category: work.category.other.1)
        }))
        
        actionSheet.popoverPresentationController?.sourceView = soruceView
        present(actionSheet, animated: true, completion: nil)
    }
    
    func send(data: Work) {
        viewModel.updateWork(data: data)
    }
    
}

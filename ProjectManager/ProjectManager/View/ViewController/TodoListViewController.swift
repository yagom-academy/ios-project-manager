//
//  ProjectManager - TodoListViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit
import Combine

final class TodoListViewController: UIViewController, SavingItemDelegate {
   
    private let todoListViewModel = TodoListViewModel()
    private var cancellables: Set<AnyCancellable> = []
    
    private let todoTableView = UITableView()
    private let doingTableView = UITableView()
    private let doneTableView = UITableView()
    
    private let tableStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = .systemGray6
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        
        return stackView
    }()
    
    private lazy var todoHeader = HeaderView(text: "TODO", frame: CGRect(x: 0, y: 0, width: todoTableView.frame.size.width, height: 50))
    private lazy var doingHeader = HeaderView(text: "DOING", frame: CGRect(x: 0, y: 0, width: todoTableView.frame.size.width, height: 50))
    private lazy var doneHeader = HeaderView(text: "DONE", frame: CGRect(x: 0, y: 0, width: todoTableView.frame.size.width, height: 50))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
        configureNavigationBar()
        bind()
        bindListCount()
    }
    
    private func setUpView() {
        view.addSubview(tableStackView)
        view.backgroundColor = .white
        setUpTodoTableView()
        setUpDoingTableView()
        setUpDoneTableView()
        setUpStackView()
    }
    
    private func setUpTodoTableView() {
        todoTableView.dataSource = self
        todoTableView.delegate = self
        todoTableView.register(TodoTableViewCell.self, forCellReuseIdentifier: "Cell")
        todoTableView.tableHeaderView = todoHeader
    }
    
    private func setUpDoingTableView() {
        doingTableView.dataSource = self
        doingTableView.register(TodoTableViewCell.self, forCellReuseIdentifier: "Cell")
        doingTableView.tableHeaderView = doingHeader
    }
    
    private func setUpDoneTableView() {
        doneTableView.dataSource = self
        doneTableView.register(TodoTableViewCell.self, forCellReuseIdentifier: "Cell")
        doneTableView.tableHeaderView = doneHeader
    }
    
    private func setUpStackView() {
        tableStackView.addArrangedSubview(todoTableView)
        tableStackView.addArrangedSubview(doingTableView)
        tableStackView.addArrangedSubview(doneTableView)
        
        let safeArea = view.safeAreaLayoutGuide
        tableStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableStackView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            tableStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 10),
            tableStackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -20),
            tableStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -10)
        ])
    }
    
    private func configureNavigationBar() {
        let title = "Project Manager"
        let plusButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(plusButtonTapped))
        
        navigationItem.title = title
        navigationItem.rightBarButtonItem = plusButton
    }
    
    @objc func plusButtonTapped() {
        let plusTodoViewModel = PlusTodoViewModel()
        plusTodoViewModel.mode = .create
        
        let plusTodoViewController = PlusTodoViewController(plusTodoViewModel: plusTodoViewModel, selectedIndexPath: nil)
        plusTodoViewController.delegate = self
        
        present(plusTodoViewController, animated: false)
    }
    
    private func bind() {
        todoListViewModel.$todoItems
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.todoTableView.reloadData()
            }
            .store(in: &cancellables)
    }
    
    private func bindListCount() {
        todoListViewModel.$todoItems
            .receive(on: DispatchQueue.main)
            .map { item in
                String(item.count)
            }
            .sink { count in
                self.todoHeader.changeCount(count)
            }
            .store(in: &cancellables)
    }
    
    func addItem(_ item: TodoItem) {
        todoListViewModel.addItem(item)
    }
    
    func updateItem(at indexPath: IndexPath, by item: TodoItem) {
        todoListViewModel.updateItem(at: indexPath.row, newItem: item)
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

extension TodoListViewController: UITableViewDelegate, UIGestureRecognizerDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = todoListViewModel.item(at: indexPath.row)
        let plusTodoViewModel = PlusTodoViewModel()
        plusTodoViewModel.todoItem = item
        plusTodoViewModel.mode = .edit
        
        let plusTodoViewController = PlusTodoViewController(plusTodoViewModel: plusTodoViewModel, selectedIndexPath: indexPath)
        plusTodoViewController.delegate = self
        
        present(plusTodoViewController, animated: false)
        
        let cell = tableView.cellForRow(at: indexPath)
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))

        longPressGesture.delegate = self
        cell?.isUserInteractionEnabled = true
        cell?.addGestureRecognizer(longPressGesture)
    }
    
    @objc private func handleLongPress(_ gestureRecognizer: UILongPressGestureRecognizer) {
        if gestureRecognizer.state == .began {
            self.becomeFirstResponder()
            guard let cell = gestureRecognizer.view as? TodoTableViewCell else { return }
            
            let popoverContentController = PopoverViewController()
            popoverContentController.modalPresentationStyle = .popover
            
            guard let popoverPresentationController = popoverContentController.popoverPresentationController else { return }
            popoverPresentationController.sourceView = cell
            popoverPresentationController.sourceRect = cell.bounds
            popoverPresentationController.permittedArrowDirections = .up
            
            present(popoverContentController, animated: true, completion: nil)
        }
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .normal, title: "delete") { [weak self] (_, _, completionHandler) in
            self?.todoListViewModel.delete(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            completionHandler(true)
        }
        deleteAction.backgroundColor = .red
        
        return  UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

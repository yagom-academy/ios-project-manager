//
//  ProjectManager - MainViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

final class MainViewController: UIViewController {
    private let todoTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .systemGray5
        
        return tableView
    }()
    
    private let doingTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .systemGray5
        
        return tableView
    }()
    
    private let doneTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .systemGray5
        
        return tableView
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 12
        stackView.backgroundColor = .systemGray5
        
        return stackView
    }()
    
    private let dataManager: DataManagerProtocol
    private var useCase: MainViewControllerUseCase
    private let viewModel: MainViewModel
    
    init(dataManager: DataManagerProtocol, useCase: MainViewControllerUseCase, viewModel: MainViewModel) {
        self.dataManager = dataManager
        self.useCase = useCase
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViewController()
        setUpBarButtonItem()
        configureUI()
        setUpTableViewLayout()
        setUpTableView()
        addPressGesture(to: [todoTableView, doingTableView, doneTableView])
    }
    
    private func setUpViewController() {
        view.backgroundColor = .systemBackground
        title = "Project Manager"
    }
    
    private func configureUI() {
        stackView.addArrangedSubview(todoTableView)
        stackView.addArrangedSubview(doingTableView)
        stackView.addArrangedSubview(doneTableView)
        
        view.addSubview(stackView)
    }
    
    private func setUpBarButtonItem() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButton))
        navigationItem.rightBarButtonItem = addButton
    }
    
    private func setUpTableViewLayout() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setUpTableView() {
        viewModel.configureTableView(todoTableView, dataSourceAndDelegate: self)
        viewModel.configureTableView(doingTableView, dataSourceAndDelegate: self)
        viewModel.configureTableView(doneTableView, dataSourceAndDelegate: self)
    }
}

// MARK: Action
extension MainViewController {
    private func setUpTableViewReloadData() {
        todoTableView.reloadData()
        doingTableView.reloadData()
        doneTableView.reloadData()
    }
    
    private func createMoveToStateAction(_ selectedCell: ProjectManager, state: TitleItem) -> UIAlertAction {
        return UIAlertAction(title: state.title, style: .default) { [weak self] _ in
            self?.viewModel.performMoveToState(selectedCell, state: state)
            self?.setUpTableViewReloadData()
        }
    }
    
    private func addPressGesture(to tableViews: [UITableView]) {
        for tableView in tableViews {
            let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handlePress(_:)))
            longPressGestureRecognizer.cancelsTouchesInView = true
            tableView.addGestureRecognizer(longPressGestureRecognizer)
        }
    }
    
    @objc private func addButton() {
        let addTODOView = AddTodoViewController(dataManager: dataManager)
        let navigationController = UINavigationController(rootViewController: addTODOView)
        let backgroundView = UIView(frame: view.bounds)
        backgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        addTODOView.view.sendSubviewToBack(backgroundView)
        addTODOView.delegate = self
        
        present(navigationController, animated: true)
    }
    
    @objc func handlePress(_ gestureRecognizer: UILongPressGestureRecognizer) {
        if gestureRecognizer.state == .began {
            let point = gestureRecognizer.location(in: gestureRecognizer.view)
            if let tableView = gestureRecognizer.view as? UITableView,
               let indexPath = tableView.indexPathForRow(at: point) {
                let selectedCell: ProjectManager
                switch (tableView, indexPath.section) {
                case (todoTableView, 1):
                    selectedCell = useCase.todoItems[indexPath.row]
                case (doingTableView, 1):
                    selectedCell = useCase.doingItems[indexPath.row]
                case (doneTableView, 1):
                    selectedCell = useCase.doneItems[indexPath.row]
                default:
                    return
                }
                
                let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
                
                switch tableView {
                case todoTableView:
                    alertController.addAction(createMoveToStateAction(selectedCell, state: .doing))
                    alertController.addAction(createMoveToStateAction(selectedCell, state: .done))
                case doingTableView:
                    alertController.addAction(createMoveToStateAction(selectedCell, state: .todo))
                    alertController.addAction(createMoveToStateAction(selectedCell, state: .done))
                case doneTableView:
                    alertController.addAction(createMoveToStateAction(selectedCell, state: .todo))
                    alertController.addAction(createMoveToStateAction(selectedCell, state: .doing))
                default:
                    break
                }
                
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                alertController.addAction(cancelAction)
                
                if let popoverPresentationController = alertController.popoverPresentationController {
                    popoverPresentationController.sourceView = tableView
                    popoverPresentationController.sourceRect = tableView.rectForRow(at: indexPath)
                }
                
                present(alertController, animated: true)
            }
        }
    }
}

// MARK: UITableViewDataSource
extension MainViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch (tableView, section) {
        case (todoTableView, 0), (doingTableView, 0), (doneTableView, 0):
            return 1
        case (todoTableView, 1):
            return useCase.todoItems.count
        case (doingTableView, 1):
            return useCase.doingItems.count
        case (doneTableView, 1):
            return useCase.doneItems.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let listCell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifier.listTitleCell, for: indexPath) as? ListTitleCell else { return UITableViewCell() }
        
        guard let descriptionCell = todoTableView.dequeueReusableCell(withIdentifier: ReuseIdentifier.descriptionCell, for: indexPath) as? DescriptionCell else { return UITableViewCell() }
        
        switch (tableView, indexPath.section) {
        case (todoTableView, 0):
            listCell.setModel(title: CellTitleNamespace.todo, count: useCase.todoItems.count)
            listCell.backgroundColor = .systemGray5
            return listCell
        case (todoTableView, 1):
            let todoItem = useCase.todoItems[indexPath.row]
            descriptionCell.setModel(title: todoItem.title, body: todoItem.body, date: todoItem.date)
            descriptionCell.isUserInteractionEnabled = true
            return descriptionCell
        case (doingTableView, 0):
            listCell.setModel(title: CellTitleNamespace.doing, count: useCase.doingItems.count)
            listCell.backgroundColor = .systemGray5
            return listCell
        case (doingTableView, 1):
            let doingItem = useCase.doingItems[indexPath.row]
            descriptionCell.setModel(title: doingItem.title, body: doingItem.body, date: doingItem.date)
            descriptionCell.isUserInteractionEnabled = true
            return descriptionCell
        case (doneTableView, 0):
            listCell.setModel(title: CellTitleNamespace.done, count: useCase.doneItems.count)
            listCell.backgroundColor = .systemGray5
            return listCell
        case (doneTableView, 1):
            let doneItem = useCase.doneItems[indexPath.row]
            descriptionCell.setModel(title: doneItem.title, body: doneItem.body, date: doneItem.date)
            descriptionCell.isUserInteractionEnabled = true
            return descriptionCell
        default:
            return UITableViewCell()
        }
    }
}

// MARK: UITableViewDelegate
extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard indexPath.section == 1 else { return }
        var selectedTodoData: ProjectManager
        
        switch tableView {
        case todoTableView:
            selectedTodoData = useCase.todoItems[indexPath.row]
        case doingTableView:
            selectedTodoData = useCase.doingItems[indexPath.row]
        case doneTableView:
            selectedTodoData = useCase.doneItems[indexPath.row]
        default:
            return
        }
        
        let addTodoView = AddTodoViewController(todoItems: selectedTodoData, dataManager: dataManager)
        let navigationController = UINavigationController(rootViewController: addTodoView)
        
        addTodoView.delegate = self
        present(navigationController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .normal, title: "Delete") { [weak self] (_, _, completionHandler) in
            guard let self else { return }
            guard indexPath.section == 1 else { return }
            var deletedItem: ProjectManager?
            switch tableView {
            case self.todoTableView:
                deletedItem = self.useCase.todoItems.remove(at: indexPath.row)
            case self.doingTableView:
                deletedItem = self.useCase.doingItems.remove(at: indexPath.row)
            case self.doneTableView:
                deletedItem = self.useCase.doneItems.remove(at: indexPath.row)
            default:
                return
            }
            
            guard let deletedItem = deletedItem else { return }
            self.dataManager.deleteTodoItem(deletedItem)
            tableView.reloadData()
            completionHandler(true)
        }
        
        delete.backgroundColor = .systemRed
        delete.image = UIImage(systemName: "trash.fill")
        
        return UISwipeActionsConfiguration(actions: [delete])
    }
}

extension MainViewController: AddTodoDelegate {
    func didAddTodoItem(title: String, body: String, date: Date) {
        dataManager.addTodoItem(title: title, body: body, date: date)
        let newTodoItem = ProjectManager(title: title, body: body, date: date)
        useCase.todoItems.append(newTodoItem)
        todoTableView.reloadData()
    }
    
    func didEditTodoItem(title: String, body: String, date: Date, index: Int) {
        switch index {
        case 0..<useCase.todoItems.count:
            useCase.todoItems = useCase.updateItems(useCase.todoItems, title: title, body: body, date: date, index: index)
            todoTableView.reloadData()
        case 0..<useCase.doingItems.count:
            useCase.doingItems = useCase.updateItems(useCase.doingItems, title: title, body: body, date: date, index: index)
            doingTableView.reloadData()
        default:
            useCase.doneItems = useCase.updateItems(useCase.doneItems, title: title, body: body, date: date, index: index)
            doingTableView.reloadData()
        }
    }
}

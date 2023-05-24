//
//  ProjectManager - PlanViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit
import Combine

final class PlanViewController: UIViewController, SavingItemDelegate {
    private let planViewModel = PlanViewModel()
    private var cancellables: Set<AnyCancellable> = []
    
    private let todoTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemGroupedBackground
        return tableView
    }()
    
    private let doingTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemGroupedBackground
        return tableView
    }()
    
    private let doneTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemGroupedBackground
        return tableView
    }()
    
    private let tableStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = .systemGray4
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        
        return stackView
    }()
    
    private lazy var todoHeader = HeaderView(text: "TODO", frame: CGRect(x: 0, y: 0, width: todoTableView.frame.size.width, height: 60))
    private lazy var doingHeader = HeaderView(text: "DOING", frame: CGRect(x: 0, y: 0, width: todoTableView.frame.size.width, height: 60))
    private lazy var doneHeader = HeaderView(text: "DONE", frame: CGRect(x: 0, y: 0, width: todoTableView.frame.size.width, height: 60))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
        configureNavigationBar()
        setUpBindings()
        setUpLongPressGesture()
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
        todoTableView.register(PlanTableViewCell.self, forCellReuseIdentifier: "Cell")
        todoTableView.tableHeaderView = todoHeader
    }
    
    private func setUpDoingTableView() {
        doingTableView.dataSource = self
        doingTableView.delegate = self
        doingTableView.register(PlanTableViewCell.self, forCellReuseIdentifier: "Cell")
        doingTableView.tableHeaderView = doingHeader
    }
    
    private func setUpDoneTableView() {
        doneTableView.dataSource = self
        doneTableView.delegate = self
        doneTableView.register(PlanTableViewCell.self, forCellReuseIdentifier: "Cell")
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
            tableStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            tableStackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -20),
            tableStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
        ])
    }
    
    private func configureNavigationBar() {
        let title = UILabel()
        title.text = "Project Manager"
        title.font = UIFont.preferredFont(forTextStyle: .title2)
        
        let plusButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(plusButtonTapped))
        
        navigationItem.titleView = title
        navigationItem.rightBarButtonItem = plusButton
    }
    
    @objc func plusButtonTapped() {
        let plusTodoViewModel = PlusTodoViewModel()
        plusTodoViewModel.changeMode(.create)
        setUpState(.todo)
        
        let plusTodoViewController = PlusTodoViewController(plusTodoViewModel: plusTodoViewModel, selectedIndexPath: nil)
        plusTodoViewController.delegate = self
        
        present(plusTodoViewController, animated: false)
    }
    
    private func setUpBindings() {
        bindItem()
        bindListCount()
    }
    
    private func bindItem() {
        planViewModel.$todoItems
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.todoTableView.reloadData()
            }
            .store(in: &cancellables)
        planViewModel.$doingItems
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.doingTableView.reloadData()
            }
            .store(in: &cancellables)
        planViewModel.$doneItems
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.doneTableView.reloadData()
            }
            .store(in: &cancellables)
    }
    
    private func bindListCount() {
        planViewModel.$todoItems
            .map { item in
                String(item.count)
            }
            .sink { [weak self] count in
                self?.todoHeader.changeCount(count)
            }
            .store(in: &cancellables)
        planViewModel.$doingItems
            .map { item in
                String(item.count)
            }
            .sink { [weak self] count in
                self?.doingHeader.changeCount(count)
            }
            .store(in: &cancellables)
        planViewModel.$doneItems
            .map { item in
                String(item.count)
            }
            .sink { [weak self] count in
                self?.doneHeader.changeCount(count)
            }
            .store(in: &cancellables)
    }

    private func delete(_ indexPath: IndexPath) {
        planViewModel.delete(at: indexPath.row)
    }
    
    private func updateItemState(at indexPath: IndexPath, _ newState: State) {
        planViewModel.updateItemState(at: indexPath.row, newState)
    }
    
    private func setUpState(_ new: State) {
        planViewModel.setUpState(new)
    }
    
    func addItem(_ item: TodoItem) {
        planViewModel.addItem(item)
    }
    
    func updateItem(at indexPath: IndexPath, by item: TodoItem) {
        planViewModel.updateItem(at: indexPath.row, newItem: item)
    }
}

extension PlanViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return planViewModel.numberOfItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? PlanTableViewCell else { return UITableViewCell() }
        let item = planViewModel.item(at: indexPath.row)
        cell.configureCell(with: item)
        
        return cell
    }
}

extension PlanViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .normal, title: "delete") { [weak self] (_, _, completionHandler) in
            self?.delete(indexPath)
            tableView.deleteRows(at: [indexPath], with: .fade)
            completionHandler(true)
        }
        deleteAction.backgroundColor = .red
        
        return  UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = planViewModel.item(at: indexPath.row)
        
        let plusTodoViewModel = PlusTodoViewModel()
        plusTodoViewModel.addItem(item)
        plusTodoViewModel.changeMode(.edit)

        let plusTodoViewController = PlusTodoViewController(plusTodoViewModel: plusTodoViewModel, selectedIndexPath: indexPath)
        plusTodoViewController.delegate = self
        
        tableView.deselectRow(at: indexPath, animated: false)
        present(plusTodoViewController, animated: false)
    }
}

extension PlanViewController: UIGestureRecognizerDelegate {
    private func setUpLongPressGesture() {
        let todoLongPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        todoLongPressGesture.minimumPressDuration = 0.5
        todoLongPressGesture.delegate = self
        todoLongPressGesture.delaysTouchesBegan = true
        
        let doingLongPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        doingLongPressGesture.minimumPressDuration = 0.5
        doingLongPressGesture.delegate = self
        doingLongPressGesture.delaysTouchesBegan = true
        
        let doneLongPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        doneLongPressGesture.minimumPressDuration = 0.5
        doneLongPressGesture.delegate = self
        doneLongPressGesture.delaysTouchesBegan = true
        
        todoTableView.addGestureRecognizer(todoLongPressGesture)
        doingTableView.addGestureRecognizer(doingLongPressGesture)
        doneTableView.addGestureRecognizer(doneLongPressGesture)
    }
    
    @objc private func handleLongPress(_ gestureRecognizer: UILongPressGestureRecognizer) {
        let location = gestureRecognizer.location(in: gestureRecognizer.view)
        guard let tableView = gestureRecognizer.view as? UITableView else { return }
        
        if gestureRecognizer.state == .began {
            guard let indexPath = tableView.indexPathForRow(at: location) else { return }
            
            UIView.animate(withDuration: 0.2) { [weak self] in
                if let cell = tableView.cellForRow(at: indexPath) as? PlanTableViewCell {
                    self?.planViewModel.updateCurrentCell(cell)
                    self?.manageAction(cell, indexPath, tableView)
                }
            }
        }
    }
    
    private func manageAction(_ cell: PlanTableViewCell, _ indexPath: IndexPath, _ tableView: UITableView) {
        guard let item = cell.fetchCellItem() else { return }
        switch item.state {
        case .todo:
            let firstActionTitle = "Move To DOING"
            let secondActionTitle = "Move To DONE"
            showActionSheet(firstActionTitle, .doing, secondActionTitle, .done, cell, indexPath, tableView)
            
        case .doing:
            let firstActionTitle = "Move To TODO"
            let secondActionTitle = "Move To DONE"
            showActionSheet(firstActionTitle, .todo, secondActionTitle, .done, cell, indexPath, tableView)
        default:
            let firstActionTitle = "Move To TODO"
            let secondActionTitle = "Move To DOING"
            showActionSheet(firstActionTitle, .todo, secondActionTitle, .doing, cell, indexPath, tableView)
        }
    }
    
    private func showActionSheet(_ firstAction: String,
                                 _ fristActionState: State,
                                 _ secondAction: String,
                                 _ secondActionState: State,
                                 _ cell: PlanTableViewCell,
                                 _ indexPath: IndexPath,
                                 _ tableView: UITableView) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let firstAction = UIAlertAction(title: firstAction, style: .default) { [weak self] _ in
            self?.buttonTapped(by: fristActionState, indexPath, tableView)
        }
        let secondAction = UIAlertAction(title: secondAction, style: .default) { [weak self] _ in
            self?.buttonTapped(by: secondActionState, indexPath, tableView)
        }
        
        alert.addAction(firstAction)
        alert.addAction(secondAction)
        
        if let popoverPresentationController = alert.popoverPresentationController {
            popoverPresentationController.sourceView = cell
            popoverPresentationController.sourceRect = cell.bounds
            popoverPresentationController.permittedArrowDirections = .up
        }
        
        present(alert, animated: true)
    }
    
    private func buttonTapped(by new: State, _ indexPath: IndexPath, _ tableView: UITableView) {
        let item = planViewModel.item(at: indexPath.row)
        
        var updateItem = item
        if tableView == todoTableView {
            updateItem.state = .todo
        } else if tableView == doingTableView {
            updateItem.state = .doing
        } else if tableView == doneTableView {
            updateItem.state = .done
        }
        
        delete(indexPath)
        tableView.deleteRows(at: [indexPath], with: .fade)
        tableView.performBatchUpdates(nil, completion: { [weak self] _ in
            updateItem.state = new
            self?.addItem(updateItem)
        })
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

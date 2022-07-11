//
//  ProjectManager - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit
import SnapKit
import RxSwift

final class MainViewController: UIViewController, UIPopoverPresentationControllerDelegate {
    
    private var todos: [Task] = []
    private var doings: [Task] = []
    private var dones: [Task] = []
    
    private let mainView = MainView()
    private let realmManager = RealmManager()
    private let viewModel = MainViewModel()
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        super.loadView()
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationItems()
        fetchData()
        
        bind()
        viewModel.fetchData()
        setupLongPressGesture(at: mainView.todoTableView)
        setupLongPressGesture(at: mainView.doingTableView)
        setupLongPressGesture(at: mainView.doneTableView)
    }
    
    private func configureNavigationItems() {
        title = "Project Manager"
        let plusButton = UIBarButtonItem(
            image: UIImage(
                systemName: "plus"
            ),
            style: .plain,
            target: self,
            action: nil
        )
        navigationItem.rightBarButtonItem = plusButton
    }
    
    private func bind() {
        
        navigationItem.rightBarButtonItem?.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.viewModel.plusButtonTapped()
            })
            .disposed(by: disposeBag)
        
        // MARK: - Draw Table View
        
        viewModel.todos
            .bind(to: mainView.todoTableView.rx.items(
                cellIdentifier: TaskTableViewCell.identifier,
                cellType: TaskTableViewCell.self)
            ) { [weak self] (row, _, cell) in
                if let task = self?.viewModel.todos.value[row] {
                    cell.setupContents(task: task)
                }
        }
        .disposed(by: disposeBag)
        
        viewModel.doings
            .bind(to: mainView.doingTableView.rx.items(
                cellIdentifier: TaskTableViewCell.identifier,
                cellType: TaskTableViewCell.self)
            ) { [weak self] (row, _, cell) in
                if let task = self?.viewModel.doings.value[row] {
                    cell.setupContents(task: task)
                }
        }
        .disposed(by: disposeBag)
        
        viewModel.dones
            .bind(to: mainView.doneTableView.rx.items(
                cellIdentifier: TaskTableViewCell.identifier,
                cellType: TaskTableViewCell.self)
            ) { [weak self] (row, _, cell) in
                if let task = self?.viewModel.dones.value[row] {
                    cell.setupContents(task: task)
                }
        }
        .disposed(by: disposeBag)
        
        // MARK: - Table Header Count
        
        viewModel.todos
            .map { String($0.count) }
            .bind(to: mainView.todoHeaderView.taskCountLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.doings
            .map { String($0.count) }
            .bind(to: mainView.doingHeaderView.taskCountLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.dones
            .map { String($0.count) }
            .bind(to: mainView.doneHeaderView.taskCountLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.showNewFormSheetView.asObservable()
            .bind(onNext: showNewFormSheetView)
            .disposed(by: disposeBag)
        
        // MARK: - Table itemSelected
        
        mainView.todoTableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                self?.mainView.todoTableView.deselectRow(
                    at: indexPath,
                    animated: true
                )
                if let task = self?.viewModel.todos.value[indexPath.row] {
                    self?.showEditFormSheetView(task: task)
                }
            })
            .disposed(by: disposeBag)
        
        mainView.doingTableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                self?.mainView.doingTableView.deselectRow(
                    at: indexPath,
                    animated: true
                )
                if let task = self?.viewModel.doings.value[indexPath.row] {
                    self?.showEditFormSheetView(task: task)
                }
            })
            .disposed(by: disposeBag)
        
        mainView.doneTableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                self?.mainView.doneTableView.deselectRow(
                    at: indexPath,
                    animated: true
                )
                if let task = self?.viewModel.dones.value[indexPath.row] {
                    self?.showEditFormSheetView(task: task)
                }
            })
            .disposed(by: disposeBag)
        
        // MARK: - Table itemDeleted
        
        mainView.todoTableView.rx.itemDeleted
            .subscribe(onNext: { [weak self] indexPath in
                if let task = self?.viewModel.todos.value[indexPath.row] {
                    self?.viewModel.deleteCell(task: task)
//                    self?.mainView.todoTableView.deleteRows(at: [indexPath], with: .fade)
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func fetchData() {
        fetchToDo()
        fetchDoing()
        fetchDone()
    }
        
    private func fetchToDo() {
        let todos = realmManager.fetch(taskType: .todo)
        self.todos = todos
    }
    
    private func fetchDoing() {
        let doings = realmManager.fetch(taskType: .doing)
        self.doings = doings
    }
    
    private func fetchDone() {
        let dones = realmManager.fetch(taskType: .done)
        self.dones = dones
    }
    
    private func showNewFormSheetView() {
        let newTodoViewContrtoller = NewFormSheetViewController()
        newTodoViewContrtoller.delegate = self
        let newTodoFormSheet = UINavigationController(
            rootViewController: newTodoViewContrtoller
        )
        newTodoFormSheet.modalPresentationStyle = .formSheet
        present(newTodoFormSheet, animated: true)
    }
}

// MARK: - Gesture Recognizer Delegate Method

extension MainViewController: UIGestureRecognizerDelegate {
    private func setupLongPressGesture(at tableView: UITableView) {
        let longPressedGesture = UILongPressGestureRecognizer(
            target: self,
            action: #selector(handleLongPress)
        )
        longPressedGesture.minimumPressDuration = 1.0
        longPressedGesture.delegate = self
        longPressedGesture.delaysTouchesBegan = true
        tableView.addGestureRecognizer(longPressedGesture)
    }
    
    @objc private func handleLongPress(gestureRecognizer: UILongPressGestureRecognizer) {
        let tableView = gestureRecognizer.view as? UITableView
        let location = gestureRecognizer.location(in: tableView)
        if gestureRecognizer.state == .began {
            if let indexPath = tableView?.indexPathForRow(at: location) {
                guard let cell = tableView?.cellForRow(at: indexPath) as? TaskTableViewCell else { return }
                let popoverWidth = mainView.frame.size.width * 0.25
                let popoverHeight = mainView.frame.size.height * 0.15
                
                let popoverViewController = PopoverViewController()
                popoverViewController.delegate = self
                popoverViewController.preferredContentSize = .init(
                    width: popoverWidth,
                    height: popoverHeight
                )
                popoverViewController.modalPresentationStyle = .popover
                
                guard let popoverPresentationController = popoverViewController.popoverPresentationController else {
                    return
                }
                popoverPresentationController.sourceView = cell
                popoverPresentationController.sourceRect = cell.bounds
                popoverPresentationController.permittedArrowDirections = .up
                
                popoverViewController.task = cell.task
                popoverViewController.setPopoverAction()
                
                present(popoverViewController, animated: true)
            }
        } else {
            return
        }
    }
}

// MARK: - TableView Method

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        
        if tableView == mainView.todoTableView {
            return todos.count
        } else if tableView == mainView.doingTableView {
            return doings.count
        } else {
            return dones.count
        }
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        
        if tableView == mainView.todoTableView {
            return generateCell(
                tableView: mainView.todoTableView,
                indexPath: indexPath,
                task: todos
            )
        } else if tableView == mainView.doingTableView {
            return generateCell(
                tableView: mainView.doingTableView,
                indexPath: indexPath,
                task: doings
            )
        } else {
            return generateCell(
                tableView: mainView.doneTableView,
                indexPath: indexPath,
                task: dones
            )
        }
    }
    
    private func generateCell(
        tableView: UITableView,
        indexPath: IndexPath,
        task: [Task]
    ) -> TaskTableViewCell {
        
        if let cell = tableView.dequeueReusableCell(
            withIdentifier: TaskTableViewCell.identifier
        ) as? TaskTableViewCell {
            cell.setupContents(task: task[indexPath.row])
            return cell
        }
        return TaskTableViewCell()
    }
    
    private func showEditFormSheetView(
        task: Task
    ) {
        let editViewController = EditFormSheetViewController()
        editViewController.delegate = self
        editViewController.task = task
        let editFormSheet = UINavigationController(
            rootViewController: editViewController
        )
        editFormSheet.modalPresentationStyle = .formSheet
        present(editFormSheet, animated: true)
    }
}

extension MainViewController: DataReloadable {
    func reloadData() {
        viewModel.fetchData()
    }
}

protocol DataReloadable: NSObject {
    func reloadData()
}

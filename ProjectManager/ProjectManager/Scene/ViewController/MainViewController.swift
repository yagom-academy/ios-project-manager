//
//  ProjectManager - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit
import SnapKit
import RealmSwift

final class MainViewController: UIViewController, UIPopoverPresentationControllerDelegate {
    
    private var todos: [Task] = [] {
        didSet {
            mainView.setTaskCount(to: todos.count, taskType: .todo)
        }
    }
    private var doings: [Task] = [] {
        didSet {
            mainView.setTaskCount(to: doings.count, taskType: .doing)
        }
    }
    private var dones: [Task] = [] {
        didSet {
            mainView.setTaskCount(to: dones.count, taskType: .done)
        }
    }
    
    private let mainView = MainView()
    private let realm = try? Realm()
    
    override func loadView() {
        super.loadView()
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationItems()
        registerTableViewInfo()
        fetchData()
        mainView.setupSubViews()
        mainView.setupUILayout()
        
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
            action: #selector(showNewFormSheetView)
        )
        navigationItem.rightBarButtonItem = plusButton
    }
    
    private func registerTableViewInfo() {
        mainView.todoTableView.delegate = self
        mainView.todoTableView.dataSource = self
        mainView.todoTableView.register(
            TaskTableViewCell.self,
            forCellReuseIdentifier: TaskTableViewCell.identifier
        )
        mainView.doingTableView.delegate = self
        mainView.doingTableView.dataSource = self
        mainView.doingTableView.register(
            TaskTableViewCell.self,
            forCellReuseIdentifier: TaskTableViewCell.identifier
        )
        mainView.doneTableView.delegate = self
        mainView.doneTableView.dataSource = self
        mainView.doneTableView.register(
            TaskTableViewCell.self,
            forCellReuseIdentifier: TaskTableViewCell.identifier
        )
    }
    
    private func fetchData() {
        fetchToDo()
        fetchDoing()
        fetchDone()
    }
        
    private func fetchToDo() {
        let todoResult = realm?.objects(Task.self).where {
            $0.taskType == .todo
        }
        
        guard let todos = todoResult else { return }
        self.todos = todos.filter { $0 == $0 }
    }
    
    private func fetchDoing() {
        let doingResult = realm?.objects(Task.self).where {
            $0.taskType == .doing
        }
        
        guard let doings = doingResult else { return }
        self.doings = doings.filter { $0 == $0 }
    }
    
    private func fetchDone() {
        let doneResult = realm?.objects(Task.self).where {
            $0.taskType == .done
        }
        
        guard let dones = doneResult else { return }
        self.dones = dones.filter { $0 == $0 }
    }
    
    @objc private func showNewFormSheetView() {
        let newTodoFormSheet = UINavigationController(
            rootViewController: NewFormSheetViewController()
        )
        newTodoFormSheet.modalPresentationStyle = .formSheet
        present(newTodoFormSheet, animated: true)
    }
}

extension MainViewController: UIGestureRecognizerDelegate {
    private func setupLongPressGesture(at tableView: UITableView) {
        let longPressedGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
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
                
                let popoverWidth = mainView.frame.size.width * 0.25
                let popoverHeight = mainView.frame.size.height * 0.15
                
                let popoverViewController = PopoverViewController()
                popoverViewController.preferredContentSize = .init(
                    width: popoverWidth,
                    height: popoverHeight
                )
                popoverViewController.modalPresentationStyle = .popover
                
                guard let popoverPresentationController = popoverViewController.popoverPresentationController,
                      let cell = tableView?.cellForRow(at: indexPath) as? TaskTableViewCell,
                      let taskType = cell.task?.taskType else {
                    return
                }
                popoverPresentationController.sourceView = cell
                popoverPresentationController.sourceRect = cell.bounds
                popoverPresentationController.permittedArrowDirections = .up
                popoverViewController.setPopoverAction(taskType)
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
    
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        if tableView == mainView.todoTableView {
            showEditFormSheetView(task: todos, indexPath: indexPath)
        } else if tableView == mainView.doingTableView {
            showEditFormSheetView(task: doings, indexPath: indexPath)
        } else {
            showEditFormSheetView(task: dones, indexPath: indexPath)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    private func showEditFormSheetView(
        task: [Task],
        indexPath: IndexPath
    ) {
        let editViewController = EditFormSheetViewController()
        editViewController.task = task[indexPath.row]
        let editFormSheet = UINavigationController(
            rootViewController: editViewController
        )
        editFormSheet.modalPresentationStyle = .formSheet
        present(editFormSheet, animated: true)
    }
    
    func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath
    ) {
        if editingStyle == .delete {
            if tableView == mainView.todoTableView {
                todos.remove(at: indexPath.row)
                deleteCell(
                    indexPath: indexPath,
                    at: mainView.todoTableView
                )
            } else if tableView == mainView.doingTableView {
                doings.remove(at: indexPath.row)
                deleteCell(
                    indexPath: indexPath,
                    at: mainView.doingTableView
                )
            } else {
                dones.remove(at: indexPath.row)
                deleteCell(
                    indexPath: indexPath,
                    at: mainView.doneTableView
                )
            }
        }
    }
    
    private func deleteCell(
        indexPath: IndexPath,
        at tableView: UITableView
    ) {
        tableView.deleteRows(
            at: [indexPath],
            with: .fade
        )
    }
}

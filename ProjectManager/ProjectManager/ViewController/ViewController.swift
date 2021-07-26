//
//  ProjectManager - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class ViewController: UIViewController {

//    var todoTasks: [Task] = [Task(title: "할일1", content: "할일내용1", deadLine: "2021.05.12", state: "todo")]
//    var doingTasks: [Task] = [Task(title: "하고있는일1", content: "하고있는일내용1", deadLine: "2021.05.13", state: "doing")]
//    var doneTasks: [Task] = [Task(title: "한일1", content: "한일내용1", deadLine: "2021.05.22", state: "done")]
    
    var todoTableViewDataSource = TaskTableViewDataSource(tasks: [Task(title: "할일1", content: "할일내용1", deadLine: "2021.05.12", state: "todo")])
    var doingTableViewDataSource = TaskTableViewDataSource(tasks: [Task(title: "하고있는1", content: "하고있는일내용1", deadLine: "2021.07.23", state: "doing")])
    var doneTableViewDataSource = TaskTableViewDataSource(tasks: [Task(title: "한1", content: "한일내용1", deadLine: "2021.08.12", state: "done")])
    
    lazy var todoTableView: TaskTableView = TaskTableView(type: "todo")
    lazy var doingTableView: TaskTableView = TaskTableView(type: "doing")
    lazy var doneTableView: TaskTableView = TaskTableView(type: "done")
    
    lazy var todoView: TaskView = TaskView(type: "todo")
    lazy var doingView: TaskView = TaskView(type: "doing")
    lazy var doneView: TaskView = TaskView(type: "done")
    
    lazy var todoLabel: TitleLabel = TitleLabel(title: "TODO")
    lazy var doingLabel: TitleLabel = TitleLabel(title: "DOING")
    lazy var doneLabel: TitleLabel = TitleLabel(title: "DONE")
    
    lazy var todoCountLabel: CountLabel = CountLabel(type: "todo")
    lazy var doingCountLabel: CountLabel = CountLabel(type: "doing")
    lazy var doneCountLabel: CountLabel = CountLabel(type: "done")
    
    lazy var titlesStackView: StackView = StackView([todoView, doingView, doneView])
    lazy var tablesStackView: StackView = StackView([todoTableView, doingTableView, doneTableView])
    
    private func addSubViews() {
        self.view.addSubview(titlesStackView)
        self.view.addSubview(tablesStackView)
        self.todoView.addSubview(todoLabel)
        self.doingView.addSubview(doingLabel)
        self.doneView.addSubview(doneLabel)
        self.todoView.addSubview(todoCountLabel)
        self.doingView.addSubview(doingCountLabel)
        self.doneView.addSubview(doneCountLabel)
    }
    
    private func configureConstraints() {
        let safeArea = self.view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            tablesStackView.topAnchor.constraint(equalTo: titlesStackView.bottomAnchor),
            tablesStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            tablesStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            tablesStackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            titlesStackView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            titlesStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            titlesStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            
            todoCountLabel.centerYAnchor.constraint(equalTo: todoLabel.centerYAnchor),
            todoCountLabel.leadingAnchor.constraint(equalTo: todoLabel.trailingAnchor, constant: 8),
            todoCountLabel.widthAnchor.constraint(equalTo: todoCountLabel.heightAnchor),
            doingCountLabel.centerYAnchor.constraint(equalTo: doingLabel.centerYAnchor),
            doingCountLabel.leadingAnchor.constraint(equalTo: doingLabel.trailingAnchor, constant: 8),
            doingCountLabel.widthAnchor.constraint(equalTo: doingCountLabel.heightAnchor),
            doneCountLabel.centerYAnchor.constraint(equalTo: doneLabel.centerYAnchor),
            doneCountLabel.leadingAnchor.constraint(equalTo: doneLabel.trailingAnchor, constant: 8),
            doneCountLabel.widthAnchor.constraint(equalTo: doneCountLabel.heightAnchor)
        ])
        
        for (titleLabel, view) in [(todoLabel, todoView), (doingLabel, doingView), (doneLabel, doneView)] {
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 15).isActive = true
            titleLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -15).isActive = true
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        }
    }
    
    override func viewDidLayoutSubviews() {
        for countLabel in [todoCountLabel, doingCountLabel, doneCountLabel] {
//            countLabel.setNeedsLayout()
//            countLabel.layoutIfNeeded()
            countLabel.layer.cornerRadius = countLabel.frame.size.height / 2
            // TODO: 라벨로 나중에 뺴줘야함
            countLabel.layer.masksToBounds = true
            print(countLabel.frame.size)
        }
    }
    
    private func configureTableViews() {
        for tableView in [todoTableView, doingTableView, doneTableView] {
            tableView.register(ItemTableViewCell.self, forCellReuseIdentifier: ItemTableViewCell.identifier)
            let dataSource = dataSourceForTableView(tableView)
            dataSource.onUpdated = { [weak self] in
                if dataSource == self?.todoTableViewDataSource {
                    self?.todoCountLabel.text = String(dataSource.taskCount)
                } else if dataSource == self?.doingTableViewDataSource {
                    self?.doingCountLabel.text = String(dataSource.taskCount)
                } else {
                    self?.doneCountLabel.text = String(dataSource.taskCount)
                }
            }
            tableView.dataSource = dataSourceForTableView(tableView)
            tableView.delegate = self
            tableView.dropDelegate = self
            tableView.dragDelegate = self
        }
    }
    
    func dataSourceForTableView(_ tableView: UITableView) -> TaskTableViewDataSource {
        if tableView == todoTableView {
            return todoTableViewDataSource
        } else if tableView == doingTableView {
            return doingTableViewDataSource
        } else {
            return doneTableViewDataSource
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Project Manager"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(clickAddBarButton))
        self.view.backgroundColor = .white
        addSubViews()
        configureConstraints()
        configureTableViews()
        self.todoCountLabel.text = String(todoTableViewDataSource.taskCount)
        self.doingCountLabel.text = String(doingTableViewDataSource.taskCount)
        self.doneCountLabel.text = String(doneTableViewDataSource.taskCount)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        for countLabel in [todoCountLabel, doingCountLabel, doneCountLabel] {
            countLabel.layer.cornerRadius = countLabel.frame.size.height / 2
            // TODO: 라벨로 나중에 뺴줘야함
            countLabel.layer.masksToBounds = true
            print(countLabel.frame.size)
        }
    }
    
    @objc func clickAddBarButton() {
        print("addbuttonClick")
        let taskFormViewController = TaskFormViewController(type: .add)
        let navigationController = UINavigationController(rootViewController: taskFormViewController)
        
        navigationController.modalPresentationStyle = .formSheet
        self.present(navigationController, animated: true, completion: nil)
        
    }
    
    func addNewTask(_ task: Task) {
        let numberOfTasks = todoTableView.numberOfRows(inSection: 0)
        todoTableViewDataSource.addTask(task, at: numberOfTasks)
        
        todoTableView.performBatchUpdates {
            todoTableView.insertRows(at: [IndexPath(row: numberOfTasks, section: 0)], with: .automatic)
        }
    }
    
    func updateEditedCell(state: String) {
        if state == "todo" {
            todoTableView.reloadRows(at: [todoTableView.indexPathForSelectedRow!], with: .automatic)
        } else if state == "doing" {
            doingTableView.reloadRows(at: [doingTableView.indexPathForSelectedRow!], with: .automatic)
        } else {
            doneTableView.reloadRows(at: [doneTableView.indexPathForSelectedRow!], with: .automatic)
        }
    }
}

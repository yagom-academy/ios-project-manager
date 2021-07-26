//
//  ProjectManager - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class ViewController: UIViewController {
    var todoTableViewDataSource = TaskTableViewDataSource(tasks: [Task(title: "할일1", content: "할일내용1", deadLine: "2021.05.12", state: .todo)])
    var doingTableViewDataSource = TaskTableViewDataSource(tasks: [Task(title: "하고있는1", content: "하고있는일내용1", deadLine: "2021.07.23", state: .doing)])
    var doneTableViewDataSource = TaskTableViewDataSource(tasks: [Task(title: "한1", content: "한일내용1", deadLine: "2021.08.12", state: .done)])
    
    lazy var todoTableView: TaskTableView = TaskTableView(state: .todo)
    lazy var doingTableView: TaskTableView = TaskTableView(state: .doing)
    lazy var doneTableView: TaskTableView = TaskTableView(state: .done)
    
    lazy var todoView: TaskView = TaskView()
    lazy var doingView: TaskView = TaskView()
    lazy var doneView: TaskView = TaskView()
    
    lazy var todoLabel: TitleLabel = TitleLabel(title: "TODO")
    lazy var doingLabel: TitleLabel = TitleLabel(title: "DOING")
    lazy var doneLabel: TitleLabel = TitleLabel(title: "DONE")
    
    lazy var todoCountLabel: CountLabel = CountLabel()
    lazy var doingCountLabel: CountLabel = CountLabel()
    lazy var doneCountLabel: CountLabel = CountLabel()
    
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
            titlesStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
        ])
        for (countLabel, titleLabel) in [(todoCountLabel, todoLabel), (doingCountLabel, doingLabel), (doneCountLabel, doneLabel)] {
            countLabel.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor).isActive = true
            countLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 8).isActive = true
            countLabel.widthAnchor.constraint(equalTo: countLabel.heightAnchor).isActive = true
        }
        
        for (titleLabel, view) in [(todoLabel, todoView), (doingLabel, doingView), (doneLabel, doneView)] {
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
            titleLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
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
            tableView.dataSource = dataSource
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
            countLabel.layer.masksToBounds = true
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

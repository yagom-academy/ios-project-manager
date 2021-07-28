//
//  ProjectManager - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class MainViewController: UIViewController {
    let todoTableViewDataSource = TaskTableViewDataSource(tasks: [Task(title: "할일1", content: "할일내용1", deadLine: "2021.05.12", state: .todo)])
    let doingTableViewDataSource = TaskTableViewDataSource(tasks: [Task(title: "하고있는1", content: "하고있는일내용1", deadLine: "2021.07.23", state: .doing)])
    let doneTableViewDataSource = TaskTableViewDataSource(tasks: [Task(title: "한1", content: "한일내용1", deadLine: "2021.08.12", state: .done)])
    
    private enum Style {
        static let titleLabelMargin: CGFloat = 10
        static let labelSpacing: CGFloat = 8
    }
    
    private var todoTableView: TaskTableView = TaskTableView(state: .todo)
    private var doingTableView: TaskTableView = TaskTableView(state: .doing)
    private var doneTableView: TaskTableView = TaskTableView(state: .done)
    
    private var todoView: TaskView = TaskView()
    private var doingView: TaskView = TaskView()
    private var doneView: TaskView = TaskView()
    
    private var todoLabel: TitleLabel = TitleLabel(title: "\(TaskType.todo)")
    private var doingLabel: TitleLabel = TitleLabel(title: "\(TaskType.doing)")
    private var doneLabel: TitleLabel = TitleLabel(title: "\(TaskType.done)")
    // TODO: 생성자로 처음 값 초기화 하기
    private var todoCountLabel: CountLabel = CountLabel()
    private var doingCountLabel: CountLabel = CountLabel()
    private var doneCountLabel: CountLabel = CountLabel()
    
    private lazy var titlesStackView: StackView = StackView([todoView, doingView, doneView])
    private lazy var tablesStackView: StackView = StackView([todoTableView, doingTableView, doneTableView])
    
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
        for (countLabel, titleLabel) in [(todoCountLabel, todoLabel),
                                         (doingCountLabel, doingLabel),
                                         (doneCountLabel, doneLabel)] {
            countLabel.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor).isActive = true
            countLabel.widthAnchor.constraint(equalTo: countLabel.heightAnchor).isActive = true
            countLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor,
                                                constant: Style.labelSpacing).isActive = true
        }
        for (titleLabel, view) in [(todoLabel, todoView),
                                   (doingLabel, doingView),
                                   (doneLabel, doneView)] {
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor,
                                            constant: Style.titleLabelMargin).isActive = true
            titleLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor,
                                               constant: Style.titleLabelMargin).isActive = true
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                constant: Style.titleLabelMargin).isActive = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = Bundle.main.infoDictionary?["CFBundleName"] as? String
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                                 target: self,
                                                                 action: #selector(clickAddBarButton))
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
        }
    }
}

// MARK: TableView 관련 함수들
extension MainViewController {
    private func configureTableViews() {
        for tableView in [todoTableView, doingTableView, doneTableView] {
            tableView.register(ItemTableViewCell.self,
                               forCellReuseIdentifier: ItemTableViewCell.identifier)
            let dataSource = dataSource(for: tableView)
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
    
    func dataSource(for tableView: UITableView) -> TaskTableViewDataSource {
        if tableView == todoTableView {
            return todoTableViewDataSource
        } else if tableView == doingTableView {
            return doingTableViewDataSource
        } else {
            return doneTableViewDataSource
        }
    }
}

// MARK: TaskFormViewController에서 호출되거나 연관된 함수들
extension MainViewController: TaskFormViewControllerDelegate {
    @objc func clickAddBarButton() {
        let taskFormViewController = TaskFormViewController(type: .add)
        taskFormViewController.delegate = self
        let navigationController = UINavigationController(rootViewController: taskFormViewController)
        navigationController.modalPresentationStyle = .formSheet
        self.present(navigationController, animated: true, completion: nil)
    }
    
    func addNewTask(_ task: Task) {
        let numberOfTasks = todoTableView.numberOfRows(inSection: 0)
        todoTableViewDataSource.add(task, at: numberOfTasks)
        todoTableView.performBatchUpdates {
            todoTableView.insertRows(at: [IndexPath(row: numberOfTasks, section: 0)],
                                     with: .automatic)
        }
    }
    
    func updateEditedCell(state: TaskType) {
        switch state {
        case .todo:
            guard let todoTableViewSelectedRow = todoTableView.indexPathForSelectedRow else { return }
            todoTableView.reloadRows(at: [todoTableViewSelectedRow], with: .automatic)
        case .doing:
            guard let doingTableViewSelectedRow = doingTableView.indexPathForSelectedRow else { return }
            doingTableView.reloadRows(at: [doingTableViewSelectedRow], with: .automatic)
        case .done:
            guard let doneTableViewSelectedRow = doneTableView.indexPathForSelectedRow else { return }
            doneTableView.reloadRows(at: [doneTableViewSelectedRow], with: .automatic)
        }
    }
}

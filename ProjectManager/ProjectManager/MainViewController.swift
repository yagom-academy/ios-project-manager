//
//  ProjectManager - MainViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

final class MainViewController: UIViewController {
    let todoList: [String] = ["todo1", "todo2", "todo3", "todo4", "todo5"]
    let doingList: [String] = ["doing1", "doing2", "doing3", "doing4"]
    let doneList: [String] = ["done1", "done2", "done3", "done4", "done5", "done6"]
    
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    
    // todo list
    private let todoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        
        return stackView
    }()
    
    private let todoTitleSatckView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .center
        stackView.backgroundColor = .systemBackground
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        return stackView
    }()
    
    private let todoTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "TODO"
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        
        return label
    }()
    
    private let todoCountLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.textColor = .white
        label.backgroundColor = .black
        label.textAlignment = .center
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        return label
    }()
    
    private let todoTitleSpacer = UIView()
    
    private let todoTableView: UITableView = {
        let tableView = UITableView()
        
        return tableView
    }()
    
    // doing list
    private let doingStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        
        return stackView
    }()
    
    private let doingTitleSatckView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .center
        stackView.backgroundColor = .systemBackground
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        return stackView
    }()
    
    private let doingLabel: UILabel = {
        let label = UILabel()
        label.text = "DOING"
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        
        return label
    }()
    
    private let doingCountLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.textColor = .white
        label.backgroundColor = .black
        label.textAlignment = .center
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        return label
    }()
    
    private let doingTitleSpacer = UIView()
    
    private let doingTableView: UITableView = {
        let tableView = UITableView()
        
        return tableView
    }()

    // done list
    private let doneStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        
        return stackView
    }()
    
    private let doneTitleSatckView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .center
        stackView.backgroundColor = .systemBackground
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        return stackView
    }()
    
    private let doneLabel: UILabel = {
        let label = UILabel()
        label.text = "DONE"
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        
        return label
    }()
    
    private let doneCountLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.textColor = .white
        label.backgroundColor = .black
        label.textAlignment = .center
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        return label
    }()
    
    private let doneTitleSpacer = UIView()
    
    private let doneTableView: UITableView = {
        let tableView = UITableView()
        
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationItem()
        setTableViews()
        setUI()
    }
    
    private func setNavigationItem() {
        navigationItem.title = "Project Manager"
        
        let addAction = UIAction { _ in
            // TODO: + 버튼 터치 시 동작 작성
            print("touch addAction")
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .add, primaryAction: addAction)
    }
    
    private func setTableViews() {
        todoTableView.dataSource = self
        todoTableView.delegate = self
        todoTableView.register(WorkCell.self, forCellReuseIdentifier: WorkCell.identifier)
        
        doingTableView.dataSource = self
        doingTableView.delegate = self
        doingTableView.register(WorkCell.self, forCellReuseIdentifier: WorkCell.identifier)

        doneTableView.dataSource = self
        doneTableView.delegate = self
        doneTableView.register(WorkCell.self, forCellReuseIdentifier: WorkCell.identifier)
    }

    private func setUI() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(mainStackView)
        
        mainStackView.addArrangedSubview(todoStackView)
        todoStackView.addArrangedSubview(todoTitleSatckView)
        todoStackView.addArrangedSubview(createDivider())
        todoStackView.addArrangedSubview(todoTableView)
        todoTitleSatckView.addArrangedSubview(todoTitleLabel)
        todoTitleSatckView.addArrangedSubview(todoCountLabel)
        todoTitleSatckView.addArrangedSubview(todoTitleSpacer)
        
        mainStackView.addArrangedSubview(doingStackView)
        doingStackView.addArrangedSubview(doingTitleSatckView)
        doingStackView.addArrangedSubview(createDivider())
        doingStackView.addArrangedSubview(doingTableView)
        doingTitleSatckView.addArrangedSubview(doingLabel)
        doingTitleSatckView.addArrangedSubview(doingCountLabel)
        doingTitleSatckView.addArrangedSubview(doingTitleSpacer)
        
        mainStackView.addArrangedSubview(doneStackView)
        doneStackView.addArrangedSubview(doneTitleSatckView)
        doneStackView.addArrangedSubview(createDivider())
        doneStackView.addArrangedSubview(doneTableView)
        doneTitleSatckView.addArrangedSubview(doneLabel)
        doneTitleSatckView.addArrangedSubview(doneCountLabel)
        doneTitleSatckView.addArrangedSubview(doneTitleSpacer)
        
        mainStackView.backgroundColor = .systemGray4
        todoTableView.backgroundColor = .systemGray6
        doingTableView.backgroundColor = .systemGray6
        doneTableView.backgroundColor = .systemGray6
        
        NSLayoutConstraint.activate([
            mainStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func createDivider() -> UIView {
        let divider: UIView = {
            let view = UIView()
            view.backgroundColor = .systemGray4
            view.translatesAutoresizingMaskIntoConstraints = false
            view.heightAnchor.constraint(equalToConstant: 1.0).isActive = true
            
            return view
        }()

        return divider
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == todoTableView {
            return todoList.count
        } else if tableView == doingTableView {
            return doingList.count
        } else {
            return doneList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WorkCell.identifier, for: indexPath) as? WorkCell else {
            return UITableViewCell()
        }
        
        if tableView == todoTableView {
            let title = "\(todoList[indexPath.row])의 제목"
            let description = "\(todoList[indexPath.row]) 의 내용입니다."
            cell.config(title: title, description: description, deadline: Date())
        } else if tableView == doingTableView {
            let title = "\(doneList[indexPath.row])의 제목"
            let description = "\(doneList[indexPath.row]) 의 내용입니다."
            cell.config(title: title, description: description, deadline: Date())
        } else {
            let title = "\(doneList[indexPath.row])의 제목"
            let description = "\(doneList[indexPath.row]) 의 내용입니다."
            cell.config(title: title, description: description, deadline: Date())
        }
        
        return cell
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { _, _, complition in
            // TODO: 테이블뷰 셀 제거 로직 작성
            print("delete tableView row")
            
            complition(true)
        }
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        
        return configuration
    }
}

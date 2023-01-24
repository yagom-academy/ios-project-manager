//
//  ProjectManager - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit
import RxSwift
import RxCocoa

final class ProjectManagerViewController: UIViewController {
    
    // MARK: View Initialization
    
    var todoTableView: UITableView = {
        let table = UITableView()
        table.register(TaskCell.self, forCellReuseIdentifier: "task")
        return table
    }()
    var doingTableView: UITableView = {
        let table = UITableView()
        table.register(TaskCell.self, forCellReuseIdentifier: "task")
        return table
    }()
    var doneTableView: UITableView = {
        let table = UITableView()
        table.register(TaskCell.self, forCellReuseIdentifier: "task")
        return table
    }()
    
    var todoStatusView: TaskStatusView = {
        let view = TaskStatusView()
        view.taskNameLabel.text = "TODO"
        return view
    }()
    var doingStatusView: TaskStatusView = {
        let view = TaskStatusView()
        view.taskNameLabel.text = "Doing"
        return view
    }()
    var doneStatusView: TaskStatusView = {
        let view = TaskStatusView()
        view.taskNameLabel.text = "DONE"
        return view
    }()
    
    var todoStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fill
        stack.axis = .vertical
        return stack
    }()
    var doingStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fill
        stack.axis = .vertical
        
        return stack
    }()
    var doneStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fill
        stack.axis = .vertical
        
        return stack
    }()
    
    var wholeStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fillEqually
        stack.axis = .horizontal
        return stack
    }()
    
    // MARK: ViewModel
    
    var viewModel: ProjectManagerViewModel?
    let disposeBag = DisposeBag()
    
    // MARK: ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationController()
        configureView()
        combineViews()
        bindViewModel()
        bindTagSwitching()
    }
}

// MARK: Functions

extension ProjectManagerViewController {
    private func configureNavigationController() {
        if let navigationController = self.navigationController {
            let navigationBar = navigationController.navigationBar
            navigationBar.backgroundColor = UIColor.systemGray
            let rightAddButton = UIBarButtonItem(barButtonSystemItem: .add, target: self,
                                                 action: #selector(tapNavigationAddButton))
            navigationItem.rightBarButtonItem = rightAddButton
            navigationItem.title = "Project Manager"
        }
    }
    
    private func configureView() {
        self.view.backgroundColor = UIColor.systemGray3
    }
    
    @objc
    private func tapNavigationAddButton() {
        let rootView = AddTaskViewController()
        let view = UINavigationController(rootViewController: rootView)
        view.modalPresentationStyle = .formSheet
        
        self.present(view, animated: true)
    }
}

// MARK: TableView Delegate

extension ProjectManagerViewController: UITableViewDelegate {
    
    private func popOver(cell: UITableViewCell, item: Task) {
        let view = TaskSwitchViewController()
        
        view.modalPresentationStyle = .popover
        view.popoverPresentationController?.sourceView = cell.contentView
        view.preferredContentSize = CGSize(width: 250, height: 100)
        view.popoverPresentationController?.permittedArrowDirections = [.left]
        
        self.present(view, animated: true)
    }
    
    private func bindTagSwitching() {
        // TODO: bind tag switcher
    }
    
    private func bindViewModel() {
        guard let viewModel = self.viewModel else { return }
        
        let updateTrigger = self.rx
                    .methodInvoked(#selector(UIViewController.viewWillAppear(_:)))
                    .map { _ in }

                let input = ProjectManagerViewModel.Input(update: updateTrigger)
                let output = viewModel.transform(input: input)

                // MARK: Status View
                
                output.todoItems
                    .map { String($0.count) }
                    .bind(to: self.todoStatusView.taskCountLabel.rx.text)
                    .disposed(by: disposeBag)

                output.doingItems
                    .map { String($0.count) }
                    .bind(to: self.doingStatusView.taskCountLabel.rx.text)
                    .disposed(by: disposeBag)

                output.doneItems
                    .map { String($0.count) }
                    .bind(to: self.doneStatusView.taskCountLabel.rx.text)
                    .disposed(by: disposeBag)

                // MARK: Table View Cell
                
                output.todoItems
                    .bind(to: self.todoTableView.rx.items) { (tableview, index, item) in
                        guard let cell = tableview.dequeueReusableCell(withIdentifier: "task") as? TaskCell
                        else { return TaskCell() }
                        // TODO: inject cell viewmodel
                        return cell
                    }
                    .disposed(by: disposeBag)

                output.doingItems
                    .bind(to: self.doingTableView.rx.items) { (tableview, index, item) in
                        guard let cell = tableview.dequeueReusableCell(withIdentifier: "task") as? TaskCell
                        else { return TaskCell() }
                        // TODO: inject cell viewmodel
                        return cell
                    }
                    .disposed(by: disposeBag)

                output.doneItems
                    .bind(to: self.doneTableView.rx.items) { (tableview, index, item) in
                        guard let cell = tableview.dequeueReusableCell(withIdentifier: "task") as? TaskCell
                        else { return TaskCell() }
                        // TODO: inject cell viewmodel
                        return cell
                    }
                    .disposed(by: disposeBag)
    }
    
}

// MARK: Layout

extension ProjectManagerViewController {
    private func combineViews() {
        todoStackView.addArrangedSubview(todoStatusView)
        todoStackView.addArrangedSubview(todoTableView)
        
        doingStackView.addArrangedSubview(doingStatusView)
        doingStackView.addArrangedSubview(doingTableView)
        
        doneStackView.addArrangedSubview(doneStatusView)
        doneStackView.addArrangedSubview(doneTableView)
        
        wholeStackView.addArrangedSubview(todoStackView)
        wholeStackView.addArrangedSubview(doingStackView)
        wholeStackView.addArrangedSubview(doneStackView)
        
        self.view.addSubview(wholeStackView)
        
        NSLayoutConstraint.activate([
            wholeStackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            wholeStackView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            wholeStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            wholeStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }
}


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
        return view
    }()
    var doingStatusView: TaskStatusView = {
        let view = TaskStatusView()
        return view
    }()
    var doneStatusView: TaskStatusView = {
        let view = TaskStatusView()
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
    
    let viewModel = ProjectManagerViewModel()
    let disposeBag = DisposeBag()
    
    // MARK: ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationController()
        configureView()
        combineViews()
        bindViewModel()
    }
}

// MARK: Fnctions

extension ProjectManagerViewController {
    private func configureNavigationController() {
        if let navigationController = self.navigationController {
            let navigationBar = navigationController.navigationBar
            navigationBar.backgroundColor = UIColor.systemGray
            let rightAddButton = UIBarButtonItem(barButtonSystemItem: .add, target: self,
                                                 action: #selector(tapNavigationAddButton))
            navigationController.title = "Project Manager"
            navigationItem.rightBarButtonItem = rightAddButton
        }
    }
    
    private func configureView() {
        self.view.backgroundColor = UIColor.systemGray3
    }
    
    @objc
    private func tapNavigationAddButton() {
        // TODO: Add some action
    }
}

// MARK: TableView Delegate

extension ProjectManagerViewController: UITableViewDelegate {
    func bindViewModel() {
        todoTableView.rx.setDelegate(self).disposed(by: disposeBag)
        viewModel.subject
            .share()
            .map { $0.filter { $0.tag == .todo } }
            .bind(to: todoTableView.rx.items) { tableview, row, item in
                guard let cell = tableview.dequeueReusableCell(withIdentifier: "task") as? TaskCell
                else {
                    return TaskCell()
                }
                cell.setUp(with: item)
                return cell
            }
            .disposed(by: disposeBag)
        
        doingTableView.rx.setDelegate(self).disposed(by: disposeBag)
        viewModel.subject
            .share()
            .map { $0.filter { $0.tag == .doing } }
            .bind(to: doingTableView.rx.items) { tableview, row, item in
                guard let cell = tableview.dequeueReusableCell(withIdentifier: "task") as? TaskCell
                else {
                    return TaskCell()
                }
                cell.setUp(with: item)
                return cell
            }
            .disposed(by: disposeBag)
        
        doneTableView.rx.setDelegate(self).disposed(by: disposeBag)
        viewModel.subject
            .share()
            .map { $0.filter { $0.tag == .done } }
            .bind(to: doneTableView.rx.items) { tableview, row, item in
                guard let cell = tableview.dequeueReusableCell(withIdentifier: "task") as? TaskCell
                else {
                    return TaskCell()
                }
                cell.setUp(with: item)
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


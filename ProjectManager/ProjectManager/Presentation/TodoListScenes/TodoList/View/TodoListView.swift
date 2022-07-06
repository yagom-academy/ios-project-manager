//
//  TodoListView.swift
//  ProjectManager
//
//  Created by 김도연 on 2022/07/06.
//

import UIKit

import SnapKit

final class TodoListView: UIView {
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.backgroundColor = .systemGray5
        
        return stackView
    }()
    
    let todoTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(TodoTableViewCell.self, forCellReuseIdentifier: TodoTableViewCell.identifier)
        
        return tableView
    }()
    
    let doingTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(TodoTableViewCell.self, forCellReuseIdentifier: TodoTableViewCell.identifier)
        
        return tableView
    }()
    
    let doneTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(TodoTableViewCell.self, forCellReuseIdentifier: TodoTableViewCell.identifier)
        
        return tableView
    }()
    
    convenience init(frame: CGRect, tableViewDelegate: UITableViewDelegate) {
        self.init(frame: frame)
        setup(delegate: tableViewDelegate)
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup(delegate: UITableViewDelegate) {
        addSubviews()
        setupConstraint()
        setupView()
        setupTableView(tableViewDelegate: delegate)
    }
    
    private func addSubviews() {
        addSubview(stackView)
        stackView.addArrangeSubviews(todoTableView, doingTableView, doneTableView)
    }
    
    private func setupConstraint() {
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func setupView() {
        backgroundColor = .systemBackground
    }
    
    private func setupTableView(tableViewDelegate: UITableViewDelegate) {
        todoTableView.delegate = tableViewDelegate
        doingTableView.delegate = tableViewDelegate
        doneTableView.delegate = tableViewDelegate
    }
    
}

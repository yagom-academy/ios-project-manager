//
//  TodoListView.swift
//  ProjectManager
//
//  Created by 김도연 on 2022/07/06.
//

import UIKit

import SnapKit

final class TodoListView: UIView {
    private let headerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.backgroundColor = .systemGray5
        
        return stackView
    }()
    
    private let todoHeaderView = TableHeaderView(title: "TODO")
    private let doingHeaderView = TableHeaderView(title: "DOING")
    private let doneHeaderView = TableHeaderView(title: "DONE")
    
    private let tableStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.backgroundColor = .systemGray5
        
        return stackView
    }()
    
    let todoTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(TodoTableViewCell.self, forCellReuseIdentifier: TodoTableViewCell.identifier)
        tableView.backgroundColor = .systemGray6
        
        return tableView
    }()
    
    let doingTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(TodoTableViewCell.self, forCellReuseIdentifier: TodoTableViewCell.identifier)
        tableView.backgroundColor = .systemGray6
        
        return tableView
    }()
    
    let doneTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(TodoTableViewCell.self, forCellReuseIdentifier: TodoTableViewCell.identifier)
        tableView.backgroundColor = .systemGray6
        
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
        addSubview(headerStackView)
        headerStackView.addArrangeSubviews(todoHeaderView, doingHeaderView, doneHeaderView)
        addSubview(tableStackView)
        tableStackView.addArrangeSubviews(todoTableView, doingTableView, doneTableView)
    }
    
    private func setupConstraint() {
        headerStackView.snp.makeConstraints {
            $0.leading.trailing.top.equalToSuperview()
            $0.height.equalTo(50)
        }
        
        tableStackView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.top.equalTo(headerStackView.snp.bottom)
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
    
    func setupHeaderTodoCountLabel(with count: Int) {
        todoHeaderView.todoListCountLabel.text = "\(count)"
    }
    
    func setupHeaderDoingCountLabel(with count: Int) {
        doingHeaderView.todoListCountLabel.text = "\(count)"
    }
    
    func setupHeaderDoneCountLabel(with count: Int) {
        doneHeaderView.todoListCountLabel.text = "\(count)"
    }
}

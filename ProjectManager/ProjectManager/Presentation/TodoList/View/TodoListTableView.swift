//
//  TodoListTableView.swift
//  ProjectManager
//
//  Created by 이시원 on 2022/07/15.
//

import UIKit

final class TodoListTableView: UIView {
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [headerView, tableView])
        stackView.axis = .vertical
        stackView.spacing = 1
        
        return stackView
    }()
    
    let headerView: TodoListHeaderView
   
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemGray6
        
        return tableView
    }()
    
    init(title: String) {
        headerView = TodoListHeaderView(title: title)
        super.init(frame: .zero)
        configureLayout()
        tableViewsCellRegister()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureLayout() {
        self.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func tableViewsCellRegister() {
        tableView.register(TodoListCell.self, forCellReuseIdentifier: TodoListCell.identifier)
    }
}

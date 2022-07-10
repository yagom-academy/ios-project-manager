//
//  TodoListView.swift
//  ProjectManager
//
//  Created by 이시원 on 2022/07/05.
//

import UIKit
import SnapKit

final class TodoListView: UIView {
    private lazy var tableStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [todoStackView, doingStackView, doneStackView])
        stackView.distribution = .fillEqually
        stackView.backgroundColor = .systemGray3
        stackView.spacing = 8
        
        return stackView
    }()
    
    private lazy var todoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [todoHeaderView, todoTableView])
        stackView.axis = .vertical
        stackView.spacing = 1
        
        return stackView
    }()
    
    let todoHeaderView = TodoListHeaderView(title: "TODO")
   
    let todoTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemGray6
        
        return tableView
    }()
    
    private lazy var doingStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [doingHeaderView, doingTableView])
        stackView.axis = .vertical
        stackView.spacing = 1
        
        return stackView
    }()
    
    let doingHeaderView = TodoListHeaderView(title: "DOING")
    
    let doingTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemGray6
        
        return tableView
    }()
    
    private lazy var doneStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [doneHeaderView, doneTableView])
        stackView.axis = .vertical
        stackView.spacing = 1
        
        return stackView
    }()
    
    let doneHeaderView = TodoListHeaderView(title: "DONE")
    
    let doneTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemGray6
        
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayout()
        self.backgroundColor = .systemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureLayout() {
        self.addSubview(tableStackView)
        tableStackView.snp.makeConstraints { make in
            make.edges.equalTo(self.safeAreaLayoutGuide)
        }
    }
}

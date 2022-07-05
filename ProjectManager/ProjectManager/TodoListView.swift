//
//  TodoListView.swift
//  ProjectManager
//
//  Created by 이시원 on 2022/07/05.
//

import UIKit
import SnapKit

class HeaderView: UIView {
    let title: String
    
    private lazy var labelStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, countLabel])
        stackView.spacing = 8
        
        return stackView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .largeTitle)
        label.text = title
        
        return label
    }()
    
    let countLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .label
        label.textColor = .systemBackground
        label.clipsToBounds = true
        label.layer.cornerRadius = 15
        label.text = "5"
        label.textAlignment = .center
        
        return label
    }()
    
    init(title: String) {
        self.title = title
        super.init(frame: .zero)
        configureLayout()
        self.backgroundColor = .systemGray6
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureLayout() {
        self.addSubview(labelStackView)
        labelStackView.snp.makeConstraints { make in
            make.top.leading.bottom.equalTo(self).inset(8)
        }
        
        countLabel.snp.makeConstraints { make in
            make.width.equalTo(countLabel.snp.height)
            make.height.equalTo(30)
        }
    }
}

class TodoListView: UIView {
    private lazy var tableStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [todoStackView, doingStackView, doneStackView])
        stackView.distribution = .fillEqually
        stackView.backgroundColor = .systemGray3
        stackView.spacing = 8
        
        return stackView
    }()
    
    private lazy var todoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [HeaderView(title: "TODO"), todoTableView])
        stackView.axis = .vertical
        stackView.spacing = 1
        
        return stackView
    }()
   
    let todoTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemGray6
        
        return tableView
    }()
    
    private lazy var doingStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [HeaderView(title: "DOING"), doingTableView])
        stackView.axis = .vertical
        stackView.spacing = 1
        
        return stackView
    }()
    
    let doingTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemGray6
        
        return tableView
    }()
    
    private lazy var doneStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [HeaderView(title: "DONE"), doneTableView])
        stackView.axis = .vertical
        stackView.spacing = 1
        
        return stackView
    }()
    
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

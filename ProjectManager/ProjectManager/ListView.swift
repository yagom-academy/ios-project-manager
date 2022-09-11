//
//  ListView.swift
//  ProjectManager
//
//  Created by bonf on 2022/09/07.
//

import UIKit

enum Status: String {
    case todo = "TODO"
    case doing = "DOING"
    case done = "DONE"
}

final class ListView: UIView {
    private var status: Status
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(TodoTableViewCell.self, forCellReuseIdentifier: TodoTableViewCell.identifier)
        
        return tableView
    }()
    
    private let titleView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let titleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 8
        
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .largeTitle)
        
        return label
    }()
    
    let listCountLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title2)
        label.textColor = .white
        label.backgroundColor = .black
        label.textAlignment = .center
        label.clipsToBounds = true
        label.layer.cornerRadius = 12
        
        return label
    }()
    
    private let emptyLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let todoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 8
        
        return stackView
    }()
    
    init(status: Status) {
        self.status = status
        titleLabel.text = status.rawValue
        listCountLabel.text = "\(tableView.visibleCells.count)"
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        setupListView()
        setupTitleStackView()
        setupWidthOfCountLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupListView() {
        self.addSubview(todoStackView)
        todoStackView.addArrangedSubview(titleView)
        todoStackView.addArrangedSubview(tableView)
        
        NSLayoutConstraint.activate([
            todoStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            todoStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant:  -4),
            todoStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            todoStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    private func setupTitleStackView() {
        titleView.addSubview(titleStackView)
        
        titleStackView.addArrangedSubview(titleLabel)
        titleStackView.addArrangedSubview(listCountLabel)
        titleStackView.addArrangedSubview(emptyLabel)
        
        NSLayoutConstraint.activate([
            titleStackView.topAnchor.constraint(equalTo: titleView.topAnchor),
            titleStackView.bottomAnchor.constraint(equalTo: titleView.bottomAnchor),
            titleStackView.leadingAnchor.constraint(equalTo: titleView.leadingAnchor, constant: 4),
            titleStackView.trailingAnchor.constraint(equalTo: titleView.trailingAnchor, constant: -4)
        ])
        
        titleLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        listCountLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    }
    
    private func setupWidthOfCountLabel() {
        NSLayoutConstraint.activate([
            listCountLabel.widthAnchor.constraint(equalTo: listCountLabel.heightAnchor)
        ])
    }
}

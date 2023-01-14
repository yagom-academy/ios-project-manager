//
//  ProjectManager - MainViewController.swift
//  Created by yagom.
//  Copyright © yagom. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    private let totalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 10
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        stackView.backgroundColor = .systemGray3
        
        return stackView
    }()
    private let todoListStackView = ListStackView(title: Constant.todo)
    private let doingListStackView = ListStackView(title: Constant.doing)
    private let doneListStackView = ListStackView(title: Constant.done)
    private var listItems = [[String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Constant.viewBackgroundColor
        configureNavigationBar()
        configureLayout()
        configureDataSource()
    }
    
    private func configureNavigationBar() {
        navigationController?.navigationBar.backgroundColor = .clear
        navigationItem.title = Constant.navigationTitle
        navigationItem.rightBarButtonItem = .init(
            barButtonSystemItem: .add,
            target: self,
            action: nil
        )
    }
    
    private func configureLayout() {
        let safeArea = view.safeAreaLayoutGuide
        
        [todoListStackView, doingListStackView, doneListStackView].forEach {
            totalStackView.addArrangedSubview($0)
        }
        view.addSubview(totalStackView)
        
        NSLayoutConstraint.activate([
            totalStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            totalStackView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            totalStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            totalStackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }
}

// MARK: - UITableViewDataSource

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: ListItemCell = tableView.dequeueReusableCell(
            withIdentifier: ListItemCell.identifier,
            for: indexPath) as? ListItemCell
        else {
            return UITableViewCell()
        }
        
        let listItem = listItems[indexPath.row]
        
        cell.configureCell(title: listItem[0], body: listItem[1], dueDate: listItem[2])
        
        return cell
    }
    
    private func configureDataSource() {
        todoListStackView.configureTableView(dataSource: self)
        doingListStackView.configureTableView(dataSource: self)
        doneListStackView.configureTableView(dataSource: self)
    }
}

private enum Constant {
    static let navigationTitle = "Project Manager"
    static let todo = "TODO"
    static let doing = "DOING"
    static let done = "DONE"
    
    static let viewBackgroundColor: UIColor = .init(cgColor: CGColor(
        red: 246,
        green: 246,
        blue: 246,
        alpha: 1)
    )
}

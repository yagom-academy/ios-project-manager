//
//  ProjectManager - MainViewController.swift
//  Created by yagom.
//  Copyright © yagom. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    typealias DataSource = UITableViewDiffableDataSource<Section, ListItem>
    
    enum Section {
        case main
    }
    
    // MARK: Properties
    
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
    
    private lazy var todoListDataSource = configureDataSource(of: .todo)
    private lazy var doingListDataSource = configureDataSource(of: .doing)
    private lazy var doneListDataSource = configureDataSource(of: .done)
    
    private var listItems = [ListItem]() {
        didSet {
            ListType.allCases.forEach { configureSnapShot(of: $0) }
        }
    }
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Constant.viewBackgroundColor
        configureNavigationBar()
        configureLayout()
        configureCountLabel()
        ListType.allCases.forEach { configureSnapShot(of: $0) }
    }
    
    // MARK: Private Methods
    
    private func configureNavigationBar() {
        navigationController?.navigationBar.backgroundColor = .clear
        navigationItem.title = Constant.navigationTitle
        navigationItem.rightBarButtonItem = .init(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addListItem)
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
    
    private func configureCountLabel() {
        todoListStackView.fetchListCount(listItems.count)
        doingListStackView.fetchListCount(listItems.count)
        doneListStackView.fetchListCount(listItems.count)
    }
    
    @objc func addListItem() {
        let viewController = ListFormViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        
        navigationController.modalPresentationStyle = .formSheet
        navigationController.preferredContentSize = .init(
            width: view.frame.width * 0.5,
            height: view.frame.height * 0.7
        )
        present(navigationController, animated: true)
    }
}

// MARK: - UITableViewDiffableDataSource & SnapShot

extension MainViewController {
    private func configureDataSource(of type: ListType) -> DataSource {
        let tableView: UITableView
        
        switch type {
        case .todo:
            tableView = todoListStackView.listTableView
        case .doing:
            tableView = doingListStackView.listTableView
        case .done:
            tableView = doneListStackView.listTableView
        }
        
        let dataSource = DataSource(tableView: tableView) { tableView, indexPath, item in
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: ListItemCell.identifier,
                for: indexPath
            ) as? ListItemCell else {
                return UITableViewCell()
            }
            
            cell.configureCell(title: item.title, body: item.body, dueDate: item.dueDate)
            
            return cell
        }
        
        return dataSource
    }
    
    private func configureSnapShot(of type: ListType) {
        var snapShot = NSDiffableDataSourceSnapshot<Section, ListItem>()
        
        snapShot.appendSections([.main])
        snapShot.appendItems(listItems)
        
        switch type {
        case .todo:
            todoListDataSource.apply(snapShot, animatingDifferences: true)
        case .doing:
            doingListDataSource.apply(snapShot, animatingDifferences: true)
        case .done:
            doneListDataSource.apply(snapShot, animatingDifferences: true)
        }
    }
}

// MARK: - NameSpace

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

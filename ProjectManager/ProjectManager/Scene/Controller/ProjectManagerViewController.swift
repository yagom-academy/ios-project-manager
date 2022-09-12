//
//  ProjectManagerViewController.swift
//  ProjectManager
//
//  Created by Groot on 2022/09/07.
//

import UIKit

private enum Design {
    static let mainStackViewSpacing: CGFloat = 8
    static let navigationTitle: String = "ProjectManager"
    static let tableViewdefaultRow = 0
}

final class ProjectManagerViewController: UIViewController {
    private var dataManager = WorkDataManager().provider
    private var items: [WorkDTO]?
    
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = Design.mainStackViewSpacing
        stackView.backgroundColor = .systemGray5
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        
        return stackView
    }()
    
    private let todoTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .systemGray6
        
        return tableView
    }()
    
    private let doingTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .systemGray6
        
        return tableView
    }()
    
    private let doneTabelView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .systemGray6
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(mainStackView)
        
        configureNavigationItems()
        configureStackViewLayout()
        configureTableViews()
    }
    
    private func configureNavigationItems() {
        let rightBarButton = UIBarButtonItem(barButtonSystemItem: .add,
                                         target: self,
                                         action: #selector(rightBarButtonDidTap))
        
        navigationItem.rightBarButtonItem = rightBarButton
        navigationItem.title = Design.navigationTitle
    }
    
    @objc private func rightBarButtonDidTap() {
        let projectCreateViewController = ProjectCreateViewController()
        let navigationController = UINavigationController(rootViewController: projectCreateViewController)
        
        navigationController.modalPresentationStyle = .formSheet
        present(navigationController, animated: true)
    }
    
    private func configureTableViews() {
        todoTableView.dataSource = self
        doingTableView.dataSource = self
        doneTabelView.dataSource = self
        
        todoTableView.delegate = self
        doingTableView.delegate = self
        doneTabelView.delegate = self
        
        [todoTableView, doingTableView, doneTabelView].forEach {
            $0.register(WorkTableViewCell.self,
                        forCellReuseIdentifier: WorkTableViewCell.reuseIdentifier)
        }
    }

    private func configureStackViewLayout() {
        NSLayoutConstraint.activate(
            [
                mainStackView.topAnchor
                    .constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                mainStackView.bottomAnchor
                    .constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                mainStackView.leadingAnchor
                    .constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                mainStackView.trailingAnchor
                    .constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
            ]
        )
        
        [todoTableView, doingTableView, doneTabelView]
            .forEach { mainStackView.addArrangedSubview($0) }
    }
}

extension ProjectManagerViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case todoTableView:
            return dataManager.read(workState: .todo).count
        case doingTableView:
            return dataManager.read(workState: .doing).count
        case doneTabelView:
            return dataManager.read(workState: .done).count
        default:
            return Design.tableViewdefaultRow
        }
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WorkTableViewCell.reuseIdentifier)
                as? WorkTableViewCell else { return UITableViewCell() }
        
        switch tableView {
        case todoTableView:
            items = dataManager.read(workState: .todo)
        case doingTableView:
            items = dataManager.read(workState: .doing)
        case doneTabelView:
            items = dataManager.read(workState: .done)
        default:
            break
        }
        
        cell.setItems(title: items?[indexPath.row].title,
                      body: items?[indexPath.row].body,
                      date: items?[indexPath.row].date.description)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = TableHeaderView()
        
        switch tableView {
        case todoTableView:
            view.setItems(title: WorkState.todo.name,
                          count: dataManager.read(workState: .todo).count.description)
        case doingTableView:
            view.setItems(title: WorkState.doing.name,
                          count: dataManager.read(workState: .doing).count.description)
        case doneTabelView:
            view.setItems(title: WorkState.done.name,
                          count: dataManager.read(workState: .done).count.description)
        default:
            break
        }
        
        return view
    }
}

extension ProjectManagerViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let projectCreateViewController = ProjectCreateViewController()
        projectCreateViewController.item = items?[indexPath.row]
        
        let navigationController = UINavigationController(rootViewController: projectCreateViewController)
        navigationController.modalPresentationStyle = .formSheet
        
        present(navigationController, animated: true)
    }
}

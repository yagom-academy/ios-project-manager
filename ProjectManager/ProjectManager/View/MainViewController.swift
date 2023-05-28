//
//  MainViewController.swift
//  ProjectManager
//
//  Created by 무리 on 2023/05/26.
//

import UIKit

class MainViewController: UIViewController {
    private let listViewModel = ListViewModel.shared
    
    private let tableStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 10
        stackView.backgroundColor = .systemGray3
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private lazy var todoListView: CustomTableViewController = {
        let tableView = CustomTableViewController(state: .todo)
        
        return tableView
    }()
    
    private lazy var doingListView: CustomTableViewController = {
        let tableView = CustomTableViewController(state: .doing)
        
        return tableView
    }()
    
    private lazy var doneListView: CustomTableViewController = {
        let tableView = CustomTableViewController(state: .done)
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureSubviews()
        configureConstraints()
        configureNavigation()
    }
    
    private func configureSubviews() {
        view.addSubview(tableStackView)
        tableStackView.addArrangedSubview(todoListView.view)
        tableStackView.addArrangedSubview(doingListView.view)
        tableStackView.addArrangedSubview(doneListView.view)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            tableStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
    }
    
    private func configureNavigation() {
        title = NameSpace.projectName

        let addProjectButton = UIBarButtonItem(barButtonSystemItem: .add,
                                               target: self,
                                               action: #selector(addProject))
        
        navigationItem.rightBarButtonItem = addProjectButton
    }
    
    @objc
    private func addProject() {
        let detailProjectViewController = DetailProjectViewController(isNewProject: true)
        detailProjectViewController.modalPresentationStyle = .formSheet
        let modalViewWithNavigation = UINavigationController(rootViewController: detailProjectViewController)
        navigationController?.present(modalViewWithNavigation, animated: true)
    }

}

private enum NameSpace {
    static let projectName = "Project Manager"
    static let delete = "Delete"
}

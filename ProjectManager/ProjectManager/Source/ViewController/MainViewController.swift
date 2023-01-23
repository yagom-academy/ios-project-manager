//  ProjectManager - MainViewController.swift
//  created by zhilly on 2023/01/11

import UIKit

final class MainViewController: UIViewController {
    
    private enum Constant {
        static let title = "Project Manager"
    }
    
    private let viewModel = ToDoListViewModel()
    
    private lazy var todoTableView: ToDoListViewController = {
        let tableView = ToDoListViewController(status: .toDo, viewModel: viewModel)
        
        return tableView
    }()
    
    private lazy var doingTableView: ToDoListViewController = {
        let tableView = ToDoListViewController(status: .doing, viewModel: viewModel)
        
        return tableView
    }()
    
    private lazy var doneTableView: ToDoListViewController = {
        let tableView = ToDoListViewController(status: .done, viewModel: viewModel)
        
        return tableView
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        view.backgroundColor = .systemBackground
        title = Constant.title
        
        setupBarButtonItem()
        setupView()
    }
    
    private func setupBarButtonItem() {
        let rightBarButton = UIBarButtonItem(image: UIImage(systemName: "plus"),
                                             style: .plain,
                                             target: self,
                                             action: #selector(presentDetailView))
        
        navigationItem.setRightBarButton(rightBarButton, animated: true)
    }
    
    private func setupView() {
        stackView.addArrangedSubview(todoTableView.view)
        stackView.addArrangedSubview(doingTableView.view)
        stackView.addArrangedSubview(doneTableView.view)
        view.addSubview(stackView)
        
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }
    
    @objc
    private func presentDetailView() {
        let addToDoViewController = AddToDoViewController(viewModel: todoTableView.viewModel)
        let navigationController = UINavigationController(rootViewController: addToDoViewController)
        
        present(navigationController, animated: true)
    }
}

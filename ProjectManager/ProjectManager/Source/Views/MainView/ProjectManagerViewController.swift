//  ProjectManager - ProjectManagerViewController.swift
//  created by zhilly on 2023/01/11

import UIKit

final class ProjectManagerViewController: UIViewController {
    
    private enum Constant {
        static let title = "Project Manager"
        static let leftBarButtonTitle = "History"
    }
    
    private let listViewModel = ToDoListViewModel()
    private let historyViewModel = HistoryViewModel()
    
    private lazy var todoTableView: ToDoListViewController = {
        let tableView = ToDoListViewController(status: .toDo, viewModel: listViewModel)
        
        return tableView
    }()
    
    private lazy var doingTableView: ToDoListViewController = {
        let tableView = ToDoListViewController(status: .doing, viewModel: listViewModel)
        
        return tableView
    }()
    
    private lazy var doneTableView: ToDoListViewController = {
        let tableView = ToDoListViewController(status: .done, viewModel: listViewModel)
        
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
        let leftBarButton = UIBarButtonItem(title: Constant.leftBarButtonTitle,
                                            style: .done,
                                            target: self,
                                            action: #selector(presentHistoryPopoverView))
        
        let rightBarButton = UIBarButtonItem(image: UIImage(systemName: "plus"),
                                             style: .plain,
                                             target: self,
                                             action: #selector(presentDetailView))
        
        navigationItem.setLeftBarButton(leftBarButton, animated: true)
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
    
    @objc
    private func presentHistoryPopoverView() {
        let popoverViewController = HistoryTableViewController(viewModel: self.historyViewModel)
        popoverViewController.modalPresentationStyle = .popover
        popoverViewController.preferredContentSize = CGSize(width: 400, height: 400)
        guard let sender = self.navigationItem.leftBarButtonItem else { return }
        
        let popoverVC = popoverViewController.popoverPresentationController
        popoverVC?.delegate = self
        popoverVC?.barButtonItem = sender
        
        popoverVC?.permittedArrowDirections = .up
        present(popoverViewController, animated: true)
    }
}

extension ProjectManagerViewController: UIPopoverPresentationControllerDelegate { }

//  ProjectManager - MainViewController.swift
//  created by zhilly on 2023/01/11

import UIKit

class MainViewController: UIViewController {
    private enum Constant {
        static let title = "Project Manager"
    }
    
    private let todoTableView: ToDoListView = {
        let tableView = ToDoListView(status: .toDo)
        
        return tableView
    }()
    
    private let doingTableView: ToDoListView = {
        let tableView = ToDoListView(status: .doing)

        return tableView
    }()
    
    private let doneTableView: ToDoListView = {
        let tableView = ToDoListView(status: .done)
 
        return tableView
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .horizontal
        stackView.spacing = 8
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
                                             action: nil)
        
        navigationItem.setRightBarButton(rightBarButton, animated: true)
    }
    
    private func setupView() {
        stackView.addArrangedSubview(todoTableView)
        stackView.addArrangedSubview(doingTableView)
        stackView.addArrangedSubview(doneTableView)
        view.addSubview(stackView)
        
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }
}
}

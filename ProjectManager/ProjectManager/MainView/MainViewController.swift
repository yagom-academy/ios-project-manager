//
//  ProjectManager - MainViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

final class MainViewController: UIViewController {
    private var toDoListViewModel: TodoListViewModel = TodoListViewModel()
    
    private let stackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .equalSpacing
        
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureRootView()
        addChildren()
        configureStackView()
    }
    
    private func configureRootView() {
        view.backgroundColor = .systemGray4
        view.addSubview(stackView)
    }
    
    private func addChildren() {
        self.addChild(TodoTableViewController(toDoListViewModel: toDoListViewModel, workState: .todo))
        self.addChild(TodoTableViewController(toDoListViewModel: toDoListViewModel, workState: .doing))
        self.addChild(TodoTableViewController(toDoListViewModel: toDoListViewModel, workState: .done))
    }
    
    private func configureStackView() {
        self.children.forEach {
            stackView.addArrangedSubview($0.view)
            NSLayoutConstraint.activate([
                $0.view.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.325)
            ])
        }
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: self.view.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
    }
}

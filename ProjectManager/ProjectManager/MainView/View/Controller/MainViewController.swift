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
        self.addChild(DoingTableViewController(toDoListViewModel: toDoListViewModel, workState: .doing))
        self.addChild(DoneTableViewController(toDoListViewModel: toDoListViewModel, workState: .done))
    }
    
    private func configureStackView() {
        self.children.forEach {
            stackView.addArrangedSubview($0.view)
            NSLayoutConstraint.activate([
                $0.view.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.325)
            ])
        }
        
        let safe = self.view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: safe.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: safe.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: safe.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: safe.bottomAnchor),
        ])
    }
}

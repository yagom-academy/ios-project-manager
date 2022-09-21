//
//  ProjectManager - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit
import RealmSwift

class TodoListViewController: UIViewController {
    private let todoListView: TodoListView
    private let doingListView: TodoListView
    private let doneListView: TodoListView
    private let realm = try! Realm()
    
    private let todoTableStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        stackView.backgroundColor = .systemGray5
        return stackView
    }()
    
    init() {
        self.todoListView = TodoListView(todoStatus: .todo)
        self.doingListView = TodoListView(todoStatus: .doing)
        self.doneListView = TodoListView(todoStatus: .done)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addNavigationBar()
        configureUI()
        setupConstraint()
    }
}

extension TodoListViewController {
    private func configureUI() {
        self.view.addSubview(self.todoTableStackView)
        self.todoTableStackView.addArrangedSubview(todoListView)
        self.todoTableStackView.addArrangedSubview(doingListView)
        self.todoTableStackView.addArrangedSubview(doneListView)
    }
    
    private func setupConstraint() {
        self.view.backgroundColor = .systemBackground
        
        NSLayoutConstraint.activate([
            self.todoTableStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.todoTableStackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.todoTableStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.todoTableStackView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func addNavigationBar() {
        self.title = "Project Manager"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: nil, action: nil)
    }
}

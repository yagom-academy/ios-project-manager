//
//  ProjectManager - TodoListViewController.swift
//  Created by bonf.
//  Copyright © yagom. All rights reserved.
// 

import UIKit

final class TodoListViewController: UIViewController {
    private var todoView = ListView(status: .todo)
    private var doingView = ListView(status: .doing)
    private var doneView = ListView(status: .done)
    
    private let viewModel = ViewModel()
    
    private let listStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.spacing = 8
        
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemGray6
        
        setupNavigationBar()
        setupListStackView()
    }
    
    private func setupListStackView() {
        self.view.addSubview(listStackView)
        self.listStackView.addArrangedSubview(self.todoView)
        self.listStackView.addArrangedSubview(self.doingView)
        self.listStackView.addArrangedSubview(self.doneView)
        
        NSLayoutConstraint.activate([
            self.listStackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.listStackView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            self.listStackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.listStackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    private func setupNavigationBar() {
        self.navigationItem.title = Design.navigationItemTitle
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                                 target: .none,
                                                                 action: nil)
    }
}

private enum Design {
    static let navigationItemTitle = "Project Manager"
}

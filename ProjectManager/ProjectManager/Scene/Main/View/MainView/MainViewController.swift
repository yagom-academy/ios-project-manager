//
//  ProjectManager - ViewController.swift
//  Created by brad, bard.
//  Copyright © yagom. All rights reserved.
// 

import UIKit

final class MainViewController: UIViewController {
    
    // MARK: - Properties

    private let toDoListTableViewController = ToDoListViewController()
    private let doingListTableViewController = DoingListTableViewController()
    private let doneListTableViewController = DoneListTableViewController()
    
    private let horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 20

        return stackView
    }()
    
    // MARK: - Life cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupSubviews()
        setupVerticalStackViewLayout()
    }
    
    // MARK: - Functions
    
    private func setupSubviews() {
        view.addSubview(horizontalStackView)
        
        [toDoListTableViewController.view, doingListTableViewController.view, doneListTableViewController.view]
            .forEach { horizontalStackView.addArrangedSubview($0) }
    }
    
    private func setupVerticalStackViewLayout() {
        NSLayoutConstraint.activate([
            horizontalStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            horizontalStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            horizontalStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            horizontalStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}

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
        stackView.spacing = 8
        stackView.backgroundColor = .systemGray3

        return stackView
    }()
    
    // MARK: - Life cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        setupVerticalStackViewLayout()
        setupView()
    }
    
    // MARK: - Functions
    
    private func setupSubviews() {
        view.addSubview(horizontalStackView)
        
        [toDoListTableViewController.view, doingListTableViewController.view, doneListTableViewController.view]
            .forEach { horizontalStackView.addArrangedSubview($0) }
    }
    
    private func setupVerticalStackViewLayout() {
        guard let navigationBarHeight = navigationController?.navigationBar.frame.height
        else { return }
        
        NSLayoutConstraint.activate([
            horizontalStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            horizontalStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -navigationBarHeight),
            horizontalStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            horizontalStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    private func setupView() {
        view.backgroundColor = #colorLiteral(red: 0.9490192533, green: 0.9490200877, blue: 0.9662286639, alpha: 1)
        setupNavigationController()
    }
    
    private func setupNavigationController() {
        navigationController?.navigationBar.topItem?.title = "Project Manager"
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .bold)
        ]
        
        let rightBarButton = UIBarButtonItem(image: UIImage(systemName: "plus"),
                                             style: .plain,
                                             target: self,
                                             action: nil)
        
        navigationItem.rightBarButtonItem = rightBarButton
    }
}

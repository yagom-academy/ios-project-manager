//
//  ProjectManager - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

final class MainViewController: UIViewController {
    // MARK: - Property
    private let todoTableView = ListViewController(scheduleType: .todo)
    private let doingTableView = ListViewController(scheduleType: .doing)
    private let doneTableView = ListViewController(scheduleType: .done)
    
    private let stackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 10
        stackView.backgroundColor = .systemGray4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupStackView()
        setupStackViewConstraint()
    }
    
    // MARK: - Helper
    private func setupStackView() {
        stackView.addArrangedSubview(todoTableView.view)
        stackView.addArrangedSubview(doingTableView.view)
        stackView.addArrangedSubview(doneTableView.view)
        view.addSubview(stackView)
    }
    
    private func setupStackViewConstraint() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
        ])
    }
    
}

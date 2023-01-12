//
//  ProjectManager - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

final class MainViewController: UIViewController {
    private let toDoTableView = UITableView()
    private let doingTableView = UITableView()
    private let doneTableView = UITableView()
    private let totalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Project Manager"
        configureView()
        configureLayout()
    }
}

// MARK: UI Configuration
extension MainViewController {
    private func configureView() {
        view.backgroundColor = .systemBackground
        [toDoTableView, doingTableView, doneTableView].forEach {
            totalStackView.addArrangedSubview($0)
        }
        
        view.addSubview(totalStackView)
    }
    
    private func configureLayout() {
        totalStackView.translatesAutoresizingMaskIntoConstraints = false
        
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            totalStackView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            totalStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            totalStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            totalStackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }
}

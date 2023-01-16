//
//  ProjectManager - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

final class MainViewController: UIViewController {
    private let toDoHeader = HeaderView(title: "TODO")
    private let doingHeader = HeaderView(title: "DOING")
    private let doneHeader = HeaderView(title: "DONE")
    private let toDoTableView = UITableView()
    private let doingTableView = UITableView()
    private let doneTableView = UITableView()
    
    private let headerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        return stackView
    }()
    
    private let tableStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        return stackView
    }()
    
    private let totalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.backgroundColor = .systemGray6
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
        view.backgroundColor = .systemGray6
        [toDoTableView, doingTableView, doneTableView].forEach {
            $0.backgroundColor = .systemGray6
            tableStackView.addArrangedSubview($0)
        }
        
        [toDoHeader, doingHeader, doneHeader].forEach {
            headerStackView.addArrangedSubview($0)
        }
        
        [headerStackView, tableStackView].forEach {
            totalStackView.addArrangedSubview($0)
        }
        
        view.addSubview(totalStackView)
    }
    
    private func configureLayout() {
        totalStackView.translatesAutoresizingMaskIntoConstraints = false
        
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            totalStackView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            totalStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 8),
            totalStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -8),
            totalStackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            
            headerStackView.heightAnchor.constraint(equalTo: safeArea.heightAnchor, multiplier: 0.09)
        ])
    }
}

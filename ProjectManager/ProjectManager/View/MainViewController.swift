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
    
    private let footerView = {
        let view = UIView()
        view.backgroundColor = NameSpace.headerAndFooterColor
        view.heightAnchor.constraint(equalToConstant: 60).isActive = true
        return view
    }()
    
    private let tabelStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 10
        stackView.backgroundColor = .systemGray4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let stackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTableStackView()
        setupStackView()
        setupStackViewConstraint()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        footerView.addTopBorder(at: .top, color: .gray, thickness: 0.3)
    }

    // MARK: - Helper
    private func setupNavigationBar() {
        let appearnce = UINavigationBarAppearance()
        appearnce.configureWithTransparentBackground()
        appearnce.backgroundColor = NameSpace.headerAndFooterColor
        
        navigationItem.title = NameSpace.title
        navigationItem.compactAppearance = appearnce
        navigationItem.standardAppearance = appearnce
        navigationItem.scrollEdgeAppearance = appearnce
    }
    
    private func setupTableStackView() {
        tabelStackView.addArrangedSubview(todoTableView.view)
        tabelStackView.addArrangedSubview(doingTableView.view)
        tabelStackView.addArrangedSubview(doneTableView.view)
    }
    
    private func setupStackView() {
        stackView.addArrangedSubview(tabelStackView)
        stackView.addArrangedSubview(footerView)
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

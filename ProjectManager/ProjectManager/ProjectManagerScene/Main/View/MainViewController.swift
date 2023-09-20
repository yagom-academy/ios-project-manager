//
//  ProjectManager - MainViewController.swift
//  Created by yagom.
//  Copyright © yagom. All rights reserved.
//

import UIKit

final class MainViewController: UIViewController {
    
    // MARK: - Private ProPerty
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        
        return stackView
    }()
    
    private let toDoListViewController: ProjectListViewController
    private let doingListViewController: ProjectListViewController
    private let doneListViewController: ProjectListViewController
    
    // MARK: - Life Cycle
    init(toDoListViewController: ProjectListViewController,
         doingListViewController: ProjectListViewController,
         doneListViewController: ProjectListViewController
    ) {
        self.toDoListViewController = toDoListViewController
        self.doingListViewController = doingListViewController
        self.doneListViewController = doneListViewController
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
}

// MARK: - Configure UI
extension MainViewController {
    private func configureUI() {
        configureNavigation()
        configureView()
        configureStackView()
        configureLayout()
    }
    
    private func configureNavigation() {
        navigationItem.title = "ProjectManager"
    }
    
    private func configureView() {
        view.addSubview(stackView)
    }
    
    private func configureStackView() {
        [toDoListViewController, doingListViewController, doneListViewController].forEach {
            addChild($0)
            stackView.addArrangedSubview($0.view)
        }
    }
    
    private func configureLayout() {
        let safe = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: safe.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: safe.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: safe.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: safe.bottomAnchor)
        ])
    }
}

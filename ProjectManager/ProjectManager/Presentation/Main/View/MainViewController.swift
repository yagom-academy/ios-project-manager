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
        stackView.backgroundColor = .systemGray3
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        
        return stackView
    }()
    
    private let viewModel: MainViewModel
    
    private let toDoListViewController: ProjectListViewController
    private let doingListViewController: ProjectListViewController
    private let doneListViewController: ProjectListViewController
    
    // MARK: - Life Cycle
    init(viewModel: MainViewModel,
         toDoListViewController: ProjectListViewController,
         doingListViewController: ProjectListViewController,
         doneListViewController: ProjectListViewController
    ) {
        self.viewModel = viewModel
        self.toDoListViewController = toDoListViewController
        self.doingListViewController = doingListViewController
        self.doneListViewController = doneListViewController
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View event
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    @objc private func tapAddButton() {
        viewModel.tapAddButton()
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
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(tapAddButton))
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .systemFill

        navigationItem.title = viewModel.navigationTitle
        navigationItem.rightBarButtonItem = addButton
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    private func configureView() {
        view.addSubview(stackView)
        view.backgroundColor = .systemBackground
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

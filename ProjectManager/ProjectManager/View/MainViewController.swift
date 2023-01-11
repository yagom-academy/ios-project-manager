//
//  ProjectManager - MainViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

final class MainViewController: UIViewController {
    private enum Constant {
        case navigationTitle
        
        var description: String {
            switch self {
            case .navigationTitle:
                return "Project Manager"
            }
        }
    }
    
    private let todoStackView = ProcessStackView(process: .todo)
    private let doingStackView = ProcessStackView(process: .doing)
    private let doneStackView = ProcessStackView(process: .done)
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [todoStackView, doingStackView, doneStackView]
        )
        stackView.spacing = 10
        stackView.alignment = .fill
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupView()
        setupConstraint()
    }
    
    @objc private func addButtonTapped() {
        // 추후 구현
    }
}

// MARK: - UI Configuration
extension MainViewController {
    private func setupNavigationBar() {
        title = Constant.navigationTitle.description
        let appearence = UINavigationBarAppearance()
        
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.backgroundColor = .systemGray6
        navigationController?.navigationBar.standardAppearance = appearence
        navigationController?.navigationBar.scrollEdgeAppearance = appearence
        
        let addBarButton = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addButtonTapped)
        )
        navigationItem.rightBarButtonItem = addBarButton
    }
    
    private func setupView() {
        view.backgroundColor = .systemGray4
        view.addSubview(mainStackView)
    }
    
    private func setupConstraint() {
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }
}

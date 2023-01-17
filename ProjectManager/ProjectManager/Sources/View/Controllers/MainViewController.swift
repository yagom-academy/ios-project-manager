//
//  MainViewController.swift
//  ProjectManager
//
//  Created by Hamo, Wonbi on 2023/01/12.
//

import UIKit

final class MainViewController: UIViewController {
    private let toDoViewController = ProjectListViewController(title: "TODO")
    private let doingViewController = ProjectListViewController(title: "DOING")
    private let doneViewController = ProjectListViewController(title: "DONE")
    
    private let totalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation()
        configureView()
        configureLayout()
    }
}

// MARK: UI Configuration
extension MainViewController {
    private func configureNavigation() {
        navigationItem.title = "Project Manager"
    }
    
    private func configureView() {
        view.backgroundColor = .systemGray6
        
        [toDoViewController, doingViewController, doneViewController].forEach {
            addChild($0)
            totalStackView.addArrangedSubview($0.view)
        }
        
        view.addSubview(totalStackView)
    }
    
    private func configureLayout() {
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            totalStackView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            totalStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 8),
            totalStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -8),
            totalStackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }
}
